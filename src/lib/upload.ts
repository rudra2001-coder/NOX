import sharp from "sharp";
import { v2 as cloudinary } from "cloudinary";
import { v4 as uuidv4 } from "uuid";

cloudinary.config({
  cloud_name: process.env.CLOUDINARY_CLOUD_NAME,
  api_key: process.env.CLOUDINARY_API_KEY,
  api_secret: process.env.CLOUDINARY_API_SECRET,
});

const MAX_FILE_SIZE =
  parseInt(process.env.MAX_FILE_SIZE_MB || "5") * 1024 * 1024;
const WEBP_QUALITY = parseInt(process.env.WEBP_QUALITY || "80");

export interface ProcessedImage {
  originalName: string;
  webpBuffer: Buffer;
  thumbnailBuffer: Buffer;
  fileName: string;
}

export interface CloudinaryUrls {
  url: string;
  thumbnailUrl: string;
  smallUrl: string;
  mediumUrl: string;
  largeUrl: string;
  publicId: string;
}

export function validateFile(file: File): { valid: boolean; error?: string } {
  if (file.size > MAX_FILE_SIZE) {
    return {
      valid: false,
      error: `File size exceeds ${MAX_FILE_SIZE / 1024 / 1024}MB limit`,
    };
  }
  const allowedTypes = ["image/jpeg", "image/png", "image/webp", "image/avif"];
  if (!allowedTypes.includes(file.type)) {
    return {
      valid: false,
      error: "Only JPEG, PNG, WebP, and AVIF images are allowed",
    };
  }
  return { valid: true };
}

export async function processImage(file: File): Promise<ProcessedImage> {
  const buffer = Buffer.from(await file.arrayBuffer());
  const ext = "webp";
  const fileName = `${uuidv4()}.${ext}`;

  const webpBuffer = await sharp(buffer)
    .webp({ quality: WEBP_QUALITY })
    .withMetadata({ exif: undefined })
    .toBuffer();

  const thumbnailBuffer = await sharp(buffer)
    .resize(100, 100, { fit: "cover" })
    .webp({ quality: 60 })
    .toBuffer();

  return {
    originalName: file.name,
    webpBuffer,
    thumbnailBuffer,
    fileName,
  };
}

export async function uploadToCloudinary(
  buffer: Buffer
): Promise<CloudinaryUrls> {
  const publicId = `nox/${uuidv4()}`;

  return new Promise((resolve, reject) => {
    const uploadStream = cloudinary.uploader.upload_stream(
      {
        public_id: publicId,
        resource_type: "image",
        overwrite: false,
      },
      (error) => {
        if (error) {
          reject(new Error(`Cloudinary upload failed: ${error.message}`));
          return;
        }

        resolve({
          url: cloudinary.url(publicId, { secure: true }),
          thumbnailUrl: cloudinary.url(publicId, {
            width: 100,
            height: 100,
            crop: "fill",
            secure: true,
          }),
          smallUrl: cloudinary.url(publicId, {
            width: 300,
            crop: "limit",
            secure: true,
          }),
          mediumUrl: cloudinary.url(publicId, {
            width: 600,
            crop: "limit",
            secure: true,
          }),
          largeUrl: cloudinary.url(publicId, {
            width: 1200,
            crop: "limit",
            secure: true,
          }),
          publicId,
        });
      }
    );

    uploadStream.end(buffer);
  });
}
