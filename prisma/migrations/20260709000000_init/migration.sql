-- CreateTable
CREATE TABLE "Admin" (
    "id" TEXT NOT NULL,
    "username" TEXT NOT NULL,
    "password_hash" TEXT NOT NULL,
    "display_name" TEXT,
    "email" TEXT,
    "avatar_id" TEXT,
    "role" TEXT NOT NULL DEFAULT 'admin',
    "is_active" BOOLEAN NOT NULL DEFAULT true,
    "last_login_at" TIMESTAMP(3),
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Admin_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "AdminSession" (
    "id" TEXT NOT NULL,
    "admin_id" TEXT NOT NULL,
    "token" TEXT NOT NULL,
    "refresh_token" TEXT,
    "ip_address" TEXT,
    "user_agent" TEXT,
    "expires_at" TIMESTAMP(3) NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "AdminSession_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Customer" (
    "id" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "password_hash" TEXT,
    "first_name" TEXT NOT NULL,
    "last_name" TEXT NOT NULL,
    "phone" TEXT,
    "avatar_id" TEXT,
    "is_guest" BOOLEAN NOT NULL DEFAULT false,
    "is_verified" BOOLEAN NOT NULL DEFAULT false,
    "verification_token" TEXT,
    "verification_sent_at" TIMESTAMP(3),
    "verified_at" TIMESTAMP(3),
    "reset_token" TEXT,
    "reset_expires" TIMESTAMP(3),
    "last_login_at" TIMESTAMP(3),
    "notes" TEXT,
    "group_id" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Customer_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "CustomerGroup" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "slug" TEXT NOT NULL,
    "description" TEXT,
    "discount" DECIMAL(5,2) DEFAULT 0,
    "is_default" BOOLEAN NOT NULL DEFAULT false,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "CustomerGroup_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "MediaFolder" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "slug" TEXT NOT NULL,
    "description" TEXT,
    "parent_id" TEXT,
    "cover_id" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "MediaFolder_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Media" (
    "id" TEXT NOT NULL,
    "folder_id" TEXT,
    "filename" TEXT NOT NULL,
    "original_name" TEXT NOT NULL,
    "alt_text" TEXT,
    "caption" TEXT,
    "credit" TEXT,
    "copyright" TEXT,
    "mime_type" TEXT NOT NULL,
    "extension" TEXT NOT NULL,
    "file_size" INTEGER NOT NULL,
    "file_type" TEXT NOT NULL,
    "width" INTEGER,
    "height" INTEGER,
    "duration" INTEGER,
    "is_animated" BOOLEAN,
    "url" TEXT NOT NULL,
    "thumbnail_url" TEXT,
    "small_url" TEXT,
    "medium_url" TEXT,
    "large_url" TEXT,
    "variants_json" TEXT,
    "storage_provider" TEXT NOT NULL DEFAULT 'local',
    "storage_bucket" TEXT,
    "storage_path" TEXT,
    "storage_key" TEXT,
    "blur_hash" TEXT,
    "status" TEXT NOT NULL DEFAULT 'ready',
    "error_message" TEXT,
    "uploaded_by_id" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Media_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "MediaUsage" (
    "id" TEXT NOT NULL,
    "media_id" TEXT NOT NULL,
    "resource_type" TEXT NOT NULL,
    "resource_id" TEXT NOT NULL,
    "usage_type" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "MediaUsage_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Category" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "slug" TEXT NOT NULL,
    "description" TEXT,
    "parent_id" TEXT,
    "icon" TEXT,
    "sort_order" INTEGER NOT NULL DEFAULT 0,
    "is_active" BOOLEAN NOT NULL DEFAULT true,
    "meta_title" TEXT,
    "meta_description" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Category_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "CategoryMedia" (
    "id" TEXT NOT NULL,
    "category_id" TEXT NOT NULL,
    "media_id" TEXT NOT NULL,
    "is_primary" BOOLEAN NOT NULL DEFAULT false,
    "sort_order" INTEGER NOT NULL DEFAULT 0,

    CONSTRAINT "CategoryMedia_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Brand" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "slug" TEXT NOT NULL,
    "description" TEXT,
    "logo_id" TEXT,
    "website_url" TEXT,
    "is_active" BOOLEAN NOT NULL DEFAULT true,
    "sort_order" INTEGER NOT NULL DEFAULT 0,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Brand_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Tag" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "slug" TEXT NOT NULL,
    "is_active" BOOLEAN NOT NULL DEFAULT true,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Tag_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ProductTag" (
    "product_id" TEXT NOT NULL,
    "tag_id" TEXT NOT NULL,

    CONSTRAINT "ProductTag_pkey" PRIMARY KEY ("product_id","tag_id")
);

-- CreateTable
CREATE TABLE "Product" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "slug" TEXT NOT NULL,
    "description" TEXT,
    "short_description" TEXT,
    "price" DECIMAL(10,2) NOT NULL,
    "compare_price" DECIMAL(10,2),
    "cost" DECIMAL(10,2),
    "stock_quantity" INTEGER NOT NULL DEFAULT 0,
    "sku" TEXT,
    "barcode" TEXT,
    "track_inventory" BOOLEAN NOT NULL DEFAULT true,
    "allow_backorder" BOOLEAN NOT NULL DEFAULT false,
    "min_order_qty" INTEGER NOT NULL DEFAULT 1,
    "max_order_qty" INTEGER,
    "weight" DECIMAL(8,2),
    "weight_unit" TEXT DEFAULT 'kg',
    "length" DECIMAL(8,2),
    "width" DECIMAL(8,2),
    "height" DECIMAL(8,2),
    "dimension_unit" TEXT DEFAULT 'cm',
    "category_id" TEXT,
    "brand_id" TEXT,
    "status" TEXT NOT NULL DEFAULT 'draft',
    "is_featured" BOOLEAN NOT NULL DEFAULT false,
    "is_taxable" BOOLEAN NOT NULL DEFAULT true,
    "tax_class_id" TEXT,
    "meta_title" TEXT,
    "meta_description" TEXT,
    "og_image_id" TEXT,
    "published_at" TIMESTAMP(3),
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Product_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ProductMedia" (
    "id" TEXT NOT NULL,
    "product_id" TEXT NOT NULL,
    "media_id" TEXT NOT NULL,
    "variant_id" TEXT,
    "is_primary" BOOLEAN NOT NULL DEFAULT false,
    "is_video" BOOLEAN NOT NULL DEFAULT false,
    "sort_order" INTEGER NOT NULL DEFAULT 0,

    CONSTRAINT "ProductMedia_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ProductOption" (
    "id" TEXT NOT NULL,
    "product_id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "type" TEXT NOT NULL DEFAULT 'select',
    "is_required" BOOLEAN NOT NULL DEFAULT false,
    "sort_order" INTEGER NOT NULL DEFAULT 0,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "ProductOption_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ProductOptionValue" (
    "id" TEXT NOT NULL,
    "option_id" TEXT NOT NULL,
    "label" TEXT NOT NULL,
    "value" TEXT NOT NULL,
    "media_id" TEXT,
    "metadata" TEXT,
    "sort_order" INTEGER NOT NULL DEFAULT 0,

    CONSTRAINT "ProductOptionValue_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ProductVariant" (
    "id" TEXT NOT NULL,
    "product_id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "sku" TEXT NOT NULL,
    "barcode" TEXT,
    "price" DECIMAL(10,2) NOT NULL DEFAULT 0,
    "compare_price" DECIMAL(10,2),
    "cost" DECIMAL(10,2),
    "stock_quantity" INTEGER NOT NULL DEFAULT 0,
    "is_active" BOOLEAN NOT NULL DEFAULT true,
    "sort_order" INTEGER NOT NULL DEFAULT 0,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "ProductVariant_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "VariantOptionValue" (
    "id" TEXT NOT NULL,
    "variant_id" TEXT NOT NULL,
    "option_value_id" TEXT NOT NULL,

    CONSTRAINT "VariantOptionValue_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ProductAttribute" (
    "id" TEXT NOT NULL,
    "product_id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "value" TEXT NOT NULL,
    "sort_order" INTEGER NOT NULL DEFAULT 0,

    CONSTRAINT "ProductAttribute_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ProductRelation" (
    "id" TEXT NOT NULL,
    "product_id" TEXT NOT NULL,
    "related_id" TEXT NOT NULL,
    "relation_type" TEXT NOT NULL,
    "sort_order" INTEGER NOT NULL DEFAULT 0,

    CONSTRAINT "ProductRelation_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PriceList" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT,
    "type" TEXT NOT NULL DEFAULT 'tier',
    "is_active" BOOLEAN NOT NULL DEFAULT true,
    "priority" INTEGER NOT NULL DEFAULT 0,
    "starts_at" TIMESTAMP(3),
    "expires_at" TIMESTAMP(3),
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "PriceList_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ProductPrice" (
    "id" TEXT NOT NULL,
    "pricelist_id" TEXT NOT NULL,
    "product_id" TEXT NOT NULL,
    "variant_id" TEXT,
    "price" DECIMAL(10,2) NOT NULL,
    "min_qty" INTEGER DEFAULT 1,
    "max_qty" INTEGER,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "ProductPrice_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "TaxClass" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "slug" TEXT NOT NULL,
    "description" TEXT,
    "is_default" BOOLEAN NOT NULL DEFAULT false,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "TaxClass_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "TaxRate" (
    "id" TEXT NOT NULL,
    "tax_class_id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "rate" DECIMAL(5,2) NOT NULL,
    "rate_type" TEXT NOT NULL DEFAULT 'percentage',
    "priority" INTEGER NOT NULL DEFAULT 0,
    "is_compound" BOOLEAN NOT NULL DEFAULT false,
    "is_shipping" BOOLEAN NOT NULL DEFAULT false,
    "country" TEXT,
    "state" TEXT,
    "zip" TEXT,
    "is_active" BOOLEAN NOT NULL DEFAULT true,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "TaxRate_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ShippingZone" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "slug" TEXT NOT NULL,
    "description" TEXT,
    "countries" TEXT NOT NULL DEFAULT '[]',
    "states" TEXT,
    "zip_patterns" TEXT,
    "is_active" BOOLEAN NOT NULL DEFAULT true,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "ShippingZone_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ShippingMethod" (
    "id" TEXT NOT NULL,
    "zone_id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "carrier" TEXT,
    "rate_type" TEXT NOT NULL DEFAULT 'flat',
    "rate_amount" DECIMAL(10,2) NOT NULL DEFAULT 0,
    "min_value" DECIMAL(10,2) DEFAULT 0,
    "max_value" DECIMAL(10,2),
    "min_weight" DECIMAL(8,2),
    "max_weight" DECIMAL(8,2),
    "is_active" BOOLEAN NOT NULL DEFAULT true,
    "sort_order" INTEGER NOT NULL DEFAULT 0,
    "estimated_days_min" INTEGER,
    "estimated_days_max" INTEGER,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "ShippingMethod_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Warehouse" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "code" TEXT NOT NULL,
    "description" TEXT,
    "address" TEXT,
    "city" TEXT,
    "state" TEXT,
    "country" TEXT NOT NULL DEFAULT 'IN',
    "postal_code" TEXT,
    "phone" TEXT,
    "email" TEXT,
    "is_active" BOOLEAN NOT NULL DEFAULT true,
    "is_primary" BOOLEAN NOT NULL DEFAULT false,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Warehouse_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "WarehouseStock" (
    "id" TEXT NOT NULL,
    "warehouse_id" TEXT NOT NULL,
    "product_id" TEXT NOT NULL,
    "variant_id" TEXT,
    "quantity" INTEGER NOT NULL DEFAULT 0,
    "reserved" INTEGER NOT NULL DEFAULT 0,
    "min_stock" INTEGER NOT NULL DEFAULT 0,
    "max_stock" INTEGER,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "WarehouseStock_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Review" (
    "id" TEXT NOT NULL,
    "product_id" TEXT NOT NULL,
    "customer_id" TEXT,
    "order_id" TEXT,
    "title" TEXT,
    "rating" INTEGER NOT NULL,
    "content" TEXT,
    "is_verified_purchase" BOOLEAN NOT NULL DEFAULT false,
    "is_approved" BOOLEAN NOT NULL DEFAULT false,
    "is_featured" BOOLEAN NOT NULL DEFAULT false,
    "helpful_count" INTEGER NOT NULL DEFAULT 0,
    "not_helpful_count" INTEGER NOT NULL DEFAULT 0,
    "moderated_by" TEXT,
    "moderated_at" TIMESTAMP(3),
    "rejection_reason" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Review_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ReviewMedia" (
    "id" TEXT NOT NULL,
    "review_id" TEXT NOT NULL,
    "media_id" TEXT NOT NULL,
    "sort_order" INTEGER NOT NULL DEFAULT 0,

    CONSTRAINT "ReviewMedia_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ReviewHelpful" (
    "id" TEXT NOT NULL,
    "review_id" TEXT NOT NULL,
    "customer_id" TEXT,
    "is_helpful" BOOLEAN NOT NULL DEFAULT true,
    "ip_address" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "ReviewHelpful_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "WishlistItem" (
    "id" TEXT NOT NULL,
    "customer_id" TEXT NOT NULL,
    "product_id" TEXT NOT NULL,
    "notes" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "WishlistItem_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "CartItem" (
    "id" TEXT NOT NULL,
    "customer_id" TEXT,
    "session_id" TEXT,
    "product_id" TEXT NOT NULL,
    "variant_id" TEXT,
    "quantity" INTEGER NOT NULL DEFAULT 1,
    "price" DECIMAL(10,2),
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "CartItem_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Coupon" (
    "id" TEXT NOT NULL,
    "code" TEXT NOT NULL,
    "description" TEXT,
    "discount_type" TEXT NOT NULL,
    "discount_value" DECIMAL(10,2) NOT NULL,
    "min_order_amount" DECIMAL(10,2),
    "max_discount" DECIMAL(10,2),
    "is_active" BOOLEAN NOT NULL DEFAULT true,
    "usage_limit" INTEGER,
    "usage_limit_per_customer" INTEGER,
    "used_count" INTEGER NOT NULL DEFAULT 0,
    "applies_to" TEXT NOT NULL DEFAULT 'all',
    "is_stackable" BOOLEAN NOT NULL DEFAULT false,
    "starts_at" TIMESTAMP(3),
    "expires_at" TIMESTAMP(3),
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Coupon_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "CouponProduct" (
    "id" TEXT NOT NULL,
    "coupon_id" TEXT NOT NULL,
    "product_id" TEXT NOT NULL,

    CONSTRAINT "CouponProduct_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "CouponUsage" (
    "id" TEXT NOT NULL,
    "coupon_id" TEXT NOT NULL,
    "customer_id" TEXT,
    "order_id" TEXT,
    "discount_amount" DECIMAL(10,2),
    "used_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "CouponUsage_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Order" (
    "id" TEXT NOT NULL,
    "order_number" TEXT NOT NULL,
    "customer_id" TEXT,
    "customer_email" TEXT NOT NULL,
    "customer_phone" TEXT,
    "customer_name" TEXT NOT NULL,
    "shipping_address_id" TEXT,
    "billing_address_id" TEXT,
    "shipping_address_snapshot" TEXT,
    "billing_address_snapshot" TEXT,
    "shipping_zone_id" TEXT,
    "shipping_method_id" TEXT,
    "shipping_method_name" TEXT,
    "shipping_cost" DECIMAL(10,2) DEFAULT 0,
    "shipping_status" TEXT,
    "subtotal" DECIMAL(10,2) NOT NULL,
    "discount_amount" DECIMAL(10,2) DEFAULT 0,
    "coupon_id" TEXT,
    "coupon_code" TEXT,
    "tax_amount" DECIMAL(10,2) DEFAULT 0,
    "total_amount" DECIMAL(10,2) NOT NULL,
    "payment_method" TEXT NOT NULL DEFAULT 'COD',
    "payment_status" TEXT NOT NULL DEFAULT 'pending',
    "paid_at" TIMESTAMP(3),
    "order_status" TEXT NOT NULL DEFAULT 'pending',
    "notes" TEXT,
    "admin_notes" TEXT,
    "is_gift" BOOLEAN NOT NULL DEFAULT false,
    "gift_message" TEXT,
    "ip_address" TEXT,
    "user_agent" TEXT,
    "currency" TEXT NOT NULL DEFAULT 'USD',
    "currency_rate" DECIMAL(10,6) DEFAULT 1,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Order_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "OrderItem" (
    "id" TEXT NOT NULL,
    "order_id" TEXT NOT NULL,
    "product_id" TEXT NOT NULL,
    "variant_id" TEXT,
    "product_name_snapshot" TEXT NOT NULL,
    "product_sku_snapshot" TEXT,
    "variant_name_snapshot" TEXT,
    "image_url_snapshot" TEXT,
    "price_snapshot" DECIMAL(10,2) NOT NULL,
    "quantity" INTEGER NOT NULL,
    "total_snapshot" DECIMAL(10,2) NOT NULL,
    "tax_snapshot" DECIMAL(10,2) DEFAULT 0,
    "tax_rate_snapshot" DECIMAL(5,2),

    CONSTRAINT "OrderItem_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "OrderStatusHistory" (
    "id" TEXT NOT NULL,
    "order_id" TEXT NOT NULL,
    "from_status" TEXT,
    "to_status" TEXT NOT NULL,
    "changed_by" TEXT,
    "note" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "OrderStatusHistory_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PaymentTransaction" (
    "id" TEXT NOT NULL,
    "order_id" TEXT NOT NULL,
    "transaction_id" TEXT,
    "gateway" TEXT NOT NULL,
    "gateway_response" TEXT,
    "amount" DECIMAL(10,2) NOT NULL,
    "currency" TEXT NOT NULL DEFAULT 'USD',
    "status" TEXT NOT NULL DEFAULT 'pending',
    "error_code" TEXT,
    "error_message" TEXT,
    "is_test" BOOLEAN NOT NULL DEFAULT false,
    "paid_at" TIMESTAMP(3),
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "PaymentTransaction_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Refund" (
    "id" TEXT NOT NULL,
    "return_id" TEXT,
    "payment_id" TEXT NOT NULL,
    "refund_id" TEXT,
    "amount" DECIMAL(10,2) NOT NULL,
    "currency" TEXT NOT NULL DEFAULT 'USD',
    "reason" TEXT,
    "status" TEXT NOT NULL DEFAULT 'pending',
    "gateway_response" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Refund_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Return" (
    "id" TEXT NOT NULL,
    "order_id" TEXT NOT NULL,
    "return_number" TEXT NOT NULL,
    "status" TEXT NOT NULL DEFAULT 'requested',
    "reason" TEXT NOT NULL,
    "customer_note" TEXT,
    "admin_note" TEXT,
    "refund_amount" DECIMAL(10,2),
    "refund_method" TEXT,
    "refunded_at" TIMESTAMP(3),
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Return_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ReturnItem" (
    "id" TEXT NOT NULL,
    "return_id" TEXT NOT NULL,
    "order_item_id" TEXT NOT NULL,
    "quantity" INTEGER NOT NULL,
    "condition" TEXT,
    "reason" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "ReturnItem_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "InventoryLog" (
    "id" TEXT NOT NULL,
    "product_id" TEXT NOT NULL,
    "variant_id" TEXT,
    "warehouse_id" TEXT,
    "change_type" TEXT NOT NULL,
    "quantity_change" INTEGER NOT NULL,
    "quantity_before" INTEGER NOT NULL,
    "quantity_after" INTEGER NOT NULL,
    "reference_type" TEXT,
    "reference_id" TEXT,
    "note" TEXT,
    "created_by" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "InventoryLog_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Page" (
    "id" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "slug" TEXT NOT NULL,
    "content_html" TEXT,
    "content_json" TEXT,
    "meta_title" TEXT,
    "meta_description" TEXT,
    "og_image_id" TEXT,
    "is_published" BOOLEAN NOT NULL DEFAULT false,
    "published_at" TIMESTAMP(3),
    "sort_order" INTEGER NOT NULL DEFAULT 0,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Page_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Banner" (
    "id" TEXT NOT NULL,
    "title" TEXT,
    "subtitle" TEXT,
    "image_id" TEXT,
    "mobile_image_id" TEXT,
    "link_url" TEXT,
    "link_text" TEXT,
    "position" TEXT NOT NULL DEFAULT 'hero',
    "is_active" BOOLEAN NOT NULL DEFAULT true,
    "sort_order" INTEGER NOT NULL DEFAULT 0,
    "bg_color" TEXT,
    "text_color" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Banner_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Redirect" (
    "id" TEXT NOT NULL,
    "from_path" TEXT NOT NULL,
    "to_path" TEXT NOT NULL,
    "status_code" INTEGER NOT NULL DEFAULT 301,
    "image_id" TEXT,
    "is_active" BOOLEAN NOT NULL DEFAULT true,
    "hit_count" INTEGER NOT NULL DEFAULT 0,
    "last_hit_at" TIMESTAMP(3),
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Redirect_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "NotificationTemplate" (
    "id" TEXT NOT NULL,
    "code" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "type" TEXT NOT NULL DEFAULT 'email',
    "subject" TEXT,
    "body_html" TEXT,
    "body_text" TEXT,
    "variables" TEXT,
    "is_active" BOOLEAN NOT NULL DEFAULT true,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "NotificationTemplate_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Notification" (
    "id" TEXT NOT NULL,
    "type" TEXT NOT NULL,
    "channel" TEXT,
    "template_id" TEXT,
    "admin_id" TEXT,
    "customer_id" TEXT,
    "order_id" TEXT,
    "recipient" TEXT NOT NULL,
    "subject" TEXT,
    "body" TEXT NOT NULL,
    "variables" TEXT,
    "status" TEXT NOT NULL DEFAULT 'pending',
    "error_message" TEXT,
    "sent_at" TIMESTAMP(3),
    "read_at" TIMESTAMP(3),
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Notification_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ActivityLog" (
    "id" TEXT NOT NULL,
    "admin_id" TEXT,
    "customer_id" TEXT,
    "action" TEXT NOT NULL,
    "resource_type" TEXT NOT NULL,
    "resource_id" TEXT,
    "resource_name" TEXT,
    "description" TEXT,
    "metadata" TEXT,
    "ip_address" TEXT,
    "user_agent" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "ActivityLog_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ApiKey" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "key_prefix" TEXT NOT NULL,
    "key_hash" TEXT NOT NULL,
    "permissions" TEXT,
    "is_active" BOOLEAN NOT NULL DEFAULT true,
    "last_used_at" TIMESTAMP(3),
    "expires_at" TIMESTAMP(3),
    "created_by" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "ApiKey_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "SiteSetting" (
    "id" TEXT NOT NULL,
    "key" TEXT NOT NULL,
    "value" TEXT,
    "image_id" TEXT,
    "type" TEXT DEFAULT 'string',
    "group" TEXT,
    "is_private" BOOLEAN NOT NULL DEFAULT false,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "SiteSetting_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Address" (
    "id" TEXT NOT NULL,
    "customer_id" TEXT NOT NULL,
    "label" TEXT,
    "first_name" TEXT NOT NULL,
    "last_name" TEXT NOT NULL,
    "phone" TEXT,
    "line1" TEXT NOT NULL,
    "line2" TEXT,
    "city" TEXT NOT NULL,
    "state" TEXT,
    "postal_code" TEXT,
    "country" TEXT NOT NULL DEFAULT 'IN',
    "is_default" BOOLEAN NOT NULL DEFAULT false,
    "is_billing" BOOLEAN NOT NULL DEFAULT true,
    "is_shipping" BOOLEAN NOT NULL DEFAULT true,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Address_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ContactSubmission" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "phone" TEXT,
    "subject" TEXT,
    "message" TEXT NOT NULL,
    "is_read" BOOLEAN NOT NULL DEFAULT false,
    "replied_at" TIMESTAMP(3),
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "ContactSubmission_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "Admin_username_key" ON "Admin"("username");

-- CreateIndex
CREATE INDEX "Admin_role_idx" ON "Admin"("role");

-- CreateIndex
CREATE INDEX "Admin_is_active_idx" ON "Admin"("is_active");

-- CreateIndex
CREATE UNIQUE INDEX "AdminSession_token_key" ON "AdminSession"("token");

-- CreateIndex
CREATE UNIQUE INDEX "AdminSession_refresh_token_key" ON "AdminSession"("refresh_token");

-- CreateIndex
CREATE INDEX "AdminSession_admin_id_idx" ON "AdminSession"("admin_id");

-- CreateIndex
CREATE INDEX "AdminSession_token_idx" ON "AdminSession"("token");

-- CreateIndex
CREATE INDEX "AdminSession_expires_at_idx" ON "AdminSession"("expires_at");

-- CreateIndex
CREATE UNIQUE INDEX "Customer_email_key" ON "Customer"("email");

-- CreateIndex
CREATE INDEX "Customer_email_idx" ON "Customer"("email");

-- CreateIndex
CREATE INDEX "Customer_is_guest_idx" ON "Customer"("is_guest");

-- CreateIndex
CREATE INDEX "Customer_group_id_idx" ON "Customer"("group_id");

-- CreateIndex
CREATE INDEX "Customer_created_at_idx" ON "Customer"("created_at");

-- CreateIndex
CREATE UNIQUE INDEX "CustomerGroup_name_key" ON "CustomerGroup"("name");

-- CreateIndex
CREATE UNIQUE INDEX "CustomerGroup_slug_key" ON "CustomerGroup"("slug");

-- CreateIndex
CREATE INDEX "CustomerGroup_slug_idx" ON "CustomerGroup"("slug");

-- CreateIndex
CREATE INDEX "CustomerGroup_is_default_idx" ON "CustomerGroup"("is_default");

-- CreateIndex
CREATE INDEX "MediaFolder_parent_id_idx" ON "MediaFolder"("parent_id");

-- CreateIndex
CREATE UNIQUE INDEX "MediaFolder_slug_parent_id_key" ON "MediaFolder"("slug", "parent_id");

-- CreateIndex
CREATE INDEX "Media_folder_id_idx" ON "Media"("folder_id");

-- CreateIndex
CREATE INDEX "Media_file_type_idx" ON "Media"("file_type");

-- CreateIndex
CREATE INDEX "Media_mime_type_idx" ON "Media"("mime_type");

-- CreateIndex
CREATE INDEX "Media_storage_provider_idx" ON "Media"("storage_provider");

-- CreateIndex
CREATE INDEX "Media_status_idx" ON "Media"("status");

-- CreateIndex
CREATE INDEX "Media_created_at_idx" ON "Media"("created_at");

-- CreateIndex
CREATE INDEX "Media_uploaded_by_id_idx" ON "Media"("uploaded_by_id");

-- CreateIndex
CREATE INDEX "MediaUsage_resource_type_resource_id_idx" ON "MediaUsage"("resource_type", "resource_id");

-- CreateIndex
CREATE INDEX "MediaUsage_media_id_idx" ON "MediaUsage"("media_id");

-- CreateIndex
CREATE UNIQUE INDEX "MediaUsage_media_id_resource_type_resource_id_usage_type_key" ON "MediaUsage"("media_id", "resource_type", "resource_id", "usage_type");

-- CreateIndex
CREATE UNIQUE INDEX "Category_slug_key" ON "Category"("slug");

-- CreateIndex
CREATE INDEX "Category_slug_idx" ON "Category"("slug");

-- CreateIndex
CREATE INDEX "Category_parent_id_idx" ON "Category"("parent_id");

-- CreateIndex
CREATE INDEX "Category_is_active_sort_order_idx" ON "Category"("is_active", "sort_order");

-- CreateIndex
CREATE INDEX "CategoryMedia_category_id_is_primary_idx" ON "CategoryMedia"("category_id", "is_primary");

-- CreateIndex
CREATE UNIQUE INDEX "CategoryMedia_category_id_media_id_key" ON "CategoryMedia"("category_id", "media_id");

-- CreateIndex
CREATE UNIQUE INDEX "Brand_name_key" ON "Brand"("name");

-- CreateIndex
CREATE UNIQUE INDEX "Brand_slug_key" ON "Brand"("slug");

-- CreateIndex
CREATE INDEX "Brand_slug_idx" ON "Brand"("slug");

-- CreateIndex
CREATE INDEX "Brand_is_active_sort_order_idx" ON "Brand"("is_active", "sort_order");

-- CreateIndex
CREATE UNIQUE INDEX "Tag_name_key" ON "Tag"("name");

-- CreateIndex
CREATE UNIQUE INDEX "Tag_slug_key" ON "Tag"("slug");

-- CreateIndex
CREATE INDEX "Tag_slug_idx" ON "Tag"("slug");

-- CreateIndex
CREATE INDEX "Tag_is_active_idx" ON "Tag"("is_active");

-- CreateIndex
CREATE INDEX "ProductTag_tag_id_idx" ON "ProductTag"("tag_id");

-- CreateIndex
CREATE UNIQUE INDEX "Product_slug_key" ON "Product"("slug");

-- CreateIndex
CREATE INDEX "Product_slug_idx" ON "Product"("slug");

-- CreateIndex
CREATE INDEX "Product_category_id_idx" ON "Product"("category_id");

-- CreateIndex
CREATE INDEX "Product_brand_id_idx" ON "Product"("brand_id");

-- CreateIndex
CREATE INDEX "Product_status_is_featured_idx" ON "Product"("status", "is_featured");

-- CreateIndex
CREATE INDEX "Product_price_idx" ON "Product"("price");

-- CreateIndex
CREATE INDEX "Product_created_at_idx" ON "Product"("created_at");

-- CreateIndex
CREATE INDEX "Product_sku_idx" ON "Product"("sku");

-- CreateIndex
CREATE INDEX "Product_barcode_idx" ON "Product"("barcode");

-- CreateIndex
CREATE INDEX "ProductMedia_product_id_is_primary_idx" ON "ProductMedia"("product_id", "is_primary");

-- CreateIndex
CREATE INDEX "ProductMedia_product_id_sort_order_idx" ON "ProductMedia"("product_id", "sort_order");

-- CreateIndex
CREATE INDEX "ProductMedia_variant_id_idx" ON "ProductMedia"("variant_id");

-- CreateIndex
CREATE UNIQUE INDEX "ProductMedia_product_id_media_id_key" ON "ProductMedia"("product_id", "media_id");

-- CreateIndex
CREATE INDEX "ProductOption_product_id_sort_order_idx" ON "ProductOption"("product_id", "sort_order");

-- CreateIndex
CREATE UNIQUE INDEX "ProductOption_product_id_name_key" ON "ProductOption"("product_id", "name");

-- CreateIndex
CREATE INDEX "ProductOptionValue_option_id_sort_order_idx" ON "ProductOptionValue"("option_id", "sort_order");

-- CreateIndex
CREATE UNIQUE INDEX "ProductOptionValue_option_id_value_key" ON "ProductOptionValue"("option_id", "value");

-- CreateIndex
CREATE UNIQUE INDEX "ProductVariant_sku_key" ON "ProductVariant"("sku");

-- CreateIndex
CREATE INDEX "ProductVariant_product_id_is_active_idx" ON "ProductVariant"("product_id", "is_active");

-- CreateIndex
CREATE INDEX "ProductVariant_sku_idx" ON "ProductVariant"("sku");

-- CreateIndex
CREATE INDEX "ProductVariant_barcode_idx" ON "ProductVariant"("barcode");

-- CreateIndex
CREATE INDEX "VariantOptionValue_option_value_id_idx" ON "VariantOptionValue"("option_value_id");

-- CreateIndex
CREATE UNIQUE INDEX "VariantOptionValue_variant_id_option_value_id_key" ON "VariantOptionValue"("variant_id", "option_value_id");

-- CreateIndex
CREATE INDEX "ProductAttribute_product_id_idx" ON "ProductAttribute"("product_id");

-- CreateIndex
CREATE INDEX "ProductAttribute_name_value_idx" ON "ProductAttribute"("name", "value");

-- CreateIndex
CREATE INDEX "ProductRelation_product_id_relation_type_idx" ON "ProductRelation"("product_id", "relation_type");

-- CreateIndex
CREATE INDEX "ProductRelation_related_id_idx" ON "ProductRelation"("related_id");

-- CreateIndex
CREATE UNIQUE INDEX "ProductRelation_product_id_related_id_relation_type_key" ON "ProductRelation"("product_id", "related_id", "relation_type");

-- CreateIndex
CREATE INDEX "PriceList_is_active_priority_idx" ON "PriceList"("is_active", "priority");

-- CreateIndex
CREATE INDEX "PriceList_type_idx" ON "PriceList"("type");

-- CreateIndex
CREATE INDEX "ProductPrice_product_id_idx" ON "ProductPrice"("product_id");

-- CreateIndex
CREATE INDEX "ProductPrice_pricelist_id_idx" ON "ProductPrice"("pricelist_id");

-- CreateIndex
CREATE UNIQUE INDEX "ProductPrice_pricelist_id_product_id_variant_id_min_qty_key" ON "ProductPrice"("pricelist_id", "product_id", "variant_id", "min_qty");

-- CreateIndex
CREATE UNIQUE INDEX "TaxClass_name_key" ON "TaxClass"("name");

-- CreateIndex
CREATE UNIQUE INDEX "TaxClass_slug_key" ON "TaxClass"("slug");

-- CreateIndex
CREATE INDEX "TaxClass_slug_idx" ON "TaxClass"("slug");

-- CreateIndex
CREATE INDEX "TaxClass_is_default_idx" ON "TaxClass"("is_default");

-- CreateIndex
CREATE INDEX "TaxRate_tax_class_id_is_active_idx" ON "TaxRate"("tax_class_id", "is_active");

-- CreateIndex
CREATE INDEX "TaxRate_country_state_idx" ON "TaxRate"("country", "state");

-- CreateIndex
CREATE UNIQUE INDEX "ShippingZone_slug_key" ON "ShippingZone"("slug");

-- CreateIndex
CREATE INDEX "ShippingZone_slug_idx" ON "ShippingZone"("slug");

-- CreateIndex
CREATE INDEX "ShippingZone_is_active_idx" ON "ShippingZone"("is_active");

-- CreateIndex
CREATE INDEX "ShippingMethod_zone_id_is_active_sort_order_idx" ON "ShippingMethod"("zone_id", "is_active", "sort_order");

-- CreateIndex
CREATE UNIQUE INDEX "Warehouse_code_key" ON "Warehouse"("code");

-- CreateIndex
CREATE INDEX "Warehouse_code_idx" ON "Warehouse"("code");

-- CreateIndex
CREATE INDEX "Warehouse_is_active_is_primary_idx" ON "Warehouse"("is_active", "is_primary");

-- CreateIndex
CREATE INDEX "WarehouseStock_product_id_idx" ON "WarehouseStock"("product_id");

-- CreateIndex
CREATE INDEX "WarehouseStock_variant_id_idx" ON "WarehouseStock"("variant_id");

-- CreateIndex
CREATE INDEX "WarehouseStock_quantity_idx" ON "WarehouseStock"("quantity");

-- CreateIndex
CREATE UNIQUE INDEX "WarehouseStock_warehouse_id_product_id_variant_id_key" ON "WarehouseStock"("warehouse_id", "product_id", "variant_id");

-- CreateIndex
CREATE INDEX "Review_product_id_is_approved_idx" ON "Review"("product_id", "is_approved");

-- CreateIndex
CREATE INDEX "Review_product_id_rating_idx" ON "Review"("product_id", "rating");

-- CreateIndex
CREATE INDEX "Review_customer_id_idx" ON "Review"("customer_id");

-- CreateIndex
CREATE INDEX "Review_created_at_idx" ON "Review"("created_at");

-- CreateIndex
CREATE UNIQUE INDEX "Review_product_id_customer_id_key" ON "Review"("product_id", "customer_id");

-- CreateIndex
CREATE INDEX "ReviewMedia_review_id_idx" ON "ReviewMedia"("review_id");

-- CreateIndex
CREATE UNIQUE INDEX "ReviewMedia_review_id_media_id_key" ON "ReviewMedia"("review_id", "media_id");

-- CreateIndex
CREATE INDEX "ReviewHelpful_review_id_idx" ON "ReviewHelpful"("review_id");

-- CreateIndex
CREATE UNIQUE INDEX "ReviewHelpful_review_id_customer_id_key" ON "ReviewHelpful"("review_id", "customer_id");

-- CreateIndex
CREATE INDEX "WishlistItem_customer_id_idx" ON "WishlistItem"("customer_id");

-- CreateIndex
CREATE INDEX "WishlistItem_product_id_idx" ON "WishlistItem"("product_id");

-- CreateIndex
CREATE UNIQUE INDEX "WishlistItem_customer_id_product_id_key" ON "WishlistItem"("customer_id", "product_id");

-- CreateIndex
CREATE INDEX "CartItem_customer_id_idx" ON "CartItem"("customer_id");

-- CreateIndex
CREATE INDEX "CartItem_session_id_idx" ON "CartItem"("session_id");

-- CreateIndex
CREATE INDEX "CartItem_product_id_idx" ON "CartItem"("product_id");

-- CreateIndex
CREATE INDEX "CartItem_variant_id_idx" ON "CartItem"("variant_id");

-- CreateIndex
CREATE UNIQUE INDEX "Coupon_code_key" ON "Coupon"("code");

-- CreateIndex
CREATE INDEX "Coupon_code_idx" ON "Coupon"("code");

-- CreateIndex
CREATE INDEX "Coupon_is_active_starts_at_expires_at_idx" ON "Coupon"("is_active", "starts_at", "expires_at");

-- CreateIndex
CREATE INDEX "Coupon_discount_type_idx" ON "Coupon"("discount_type");

-- CreateIndex
CREATE INDEX "CouponProduct_product_id_idx" ON "CouponProduct"("product_id");

-- CreateIndex
CREATE UNIQUE INDEX "CouponProduct_coupon_id_product_id_key" ON "CouponProduct"("coupon_id", "product_id");

-- CreateIndex
CREATE INDEX "CouponUsage_coupon_id_idx" ON "CouponUsage"("coupon_id");

-- CreateIndex
CREATE INDEX "CouponUsage_customer_id_idx" ON "CouponUsage"("customer_id");

-- CreateIndex
CREATE INDEX "CouponUsage_order_id_idx" ON "CouponUsage"("order_id");

-- CreateIndex
CREATE UNIQUE INDEX "Order_order_number_key" ON "Order"("order_number");

-- CreateIndex
CREATE INDEX "Order_order_number_idx" ON "Order"("order_number");

-- CreateIndex
CREATE INDEX "Order_customer_id_idx" ON "Order"("customer_id");

-- CreateIndex
CREATE INDEX "Order_order_status_idx" ON "Order"("order_status");

-- CreateIndex
CREATE INDEX "Order_payment_status_idx" ON "Order"("payment_status");

-- CreateIndex
CREATE INDEX "Order_created_at_idx" ON "Order"("created_at");

-- CreateIndex
CREATE INDEX "Order_customer_email_idx" ON "Order"("customer_email");

-- CreateIndex
CREATE INDEX "OrderItem_order_id_idx" ON "OrderItem"("order_id");

-- CreateIndex
CREATE INDEX "OrderItem_product_id_idx" ON "OrderItem"("product_id");

-- CreateIndex
CREATE INDEX "OrderItem_variant_id_idx" ON "OrderItem"("variant_id");

-- CreateIndex
CREATE INDEX "OrderStatusHistory_order_id_idx" ON "OrderStatusHistory"("order_id");

-- CreateIndex
CREATE INDEX "OrderStatusHistory_created_at_idx" ON "OrderStatusHistory"("created_at");

-- CreateIndex
CREATE INDEX "PaymentTransaction_order_id_idx" ON "PaymentTransaction"("order_id");

-- CreateIndex
CREATE INDEX "PaymentTransaction_transaction_id_idx" ON "PaymentTransaction"("transaction_id");

-- CreateIndex
CREATE INDEX "PaymentTransaction_gateway_idx" ON "PaymentTransaction"("gateway");

-- CreateIndex
CREATE INDEX "PaymentTransaction_status_idx" ON "PaymentTransaction"("status");

-- CreateIndex
CREATE INDEX "Refund_payment_id_idx" ON "Refund"("payment_id");

-- CreateIndex
CREATE INDEX "Refund_return_id_idx" ON "Refund"("return_id");

-- CreateIndex
CREATE UNIQUE INDEX "Return_return_number_key" ON "Return"("return_number");

-- CreateIndex
CREATE INDEX "Return_order_id_idx" ON "Return"("order_id");

-- CreateIndex
CREATE INDEX "Return_status_idx" ON "Return"("status");

-- CreateIndex
CREATE INDEX "ReturnItem_return_id_idx" ON "ReturnItem"("return_id");

-- CreateIndex
CREATE INDEX "ReturnItem_order_item_id_idx" ON "ReturnItem"("order_item_id");

-- CreateIndex
CREATE INDEX "InventoryLog_product_id_idx" ON "InventoryLog"("product_id");

-- CreateIndex
CREATE INDEX "InventoryLog_variant_id_idx" ON "InventoryLog"("variant_id");

-- CreateIndex
CREATE INDEX "InventoryLog_warehouse_id_idx" ON "InventoryLog"("warehouse_id");

-- CreateIndex
CREATE INDEX "InventoryLog_created_at_idx" ON "InventoryLog"("created_at");

-- CreateIndex
CREATE INDEX "InventoryLog_reference_type_reference_id_idx" ON "InventoryLog"("reference_type", "reference_id");

-- CreateIndex
CREATE UNIQUE INDEX "Page_slug_key" ON "Page"("slug");

-- CreateIndex
CREATE INDEX "Page_slug_idx" ON "Page"("slug");

-- CreateIndex
CREATE INDEX "Page_is_published_published_at_idx" ON "Page"("is_published", "published_at");

-- CreateIndex
CREATE INDEX "Banner_position_is_active_sort_order_idx" ON "Banner"("position", "is_active", "sort_order");

-- CreateIndex
CREATE UNIQUE INDEX "Redirect_from_path_key" ON "Redirect"("from_path");

-- CreateIndex
CREATE INDEX "Redirect_from_path_idx" ON "Redirect"("from_path");

-- CreateIndex
CREATE INDEX "Redirect_is_active_idx" ON "Redirect"("is_active");

-- CreateIndex
CREATE UNIQUE INDEX "NotificationTemplate_code_key" ON "NotificationTemplate"("code");

-- CreateIndex
CREATE INDEX "NotificationTemplate_code_idx" ON "NotificationTemplate"("code");

-- CreateIndex
CREATE INDEX "NotificationTemplate_type_idx" ON "NotificationTemplate"("type");

-- CreateIndex
CREATE INDEX "Notification_admin_id_idx" ON "Notification"("admin_id");

-- CreateIndex
CREATE INDEX "Notification_customer_id_idx" ON "Notification"("customer_id");

-- CreateIndex
CREATE INDEX "Notification_status_idx" ON "Notification"("status");

-- CreateIndex
CREATE INDEX "Notification_type_idx" ON "Notification"("type");

-- CreateIndex
CREATE INDEX "Notification_created_at_idx" ON "Notification"("created_at");

-- CreateIndex
CREATE INDEX "ActivityLog_admin_id_idx" ON "ActivityLog"("admin_id");

-- CreateIndex
CREATE INDEX "ActivityLog_customer_id_idx" ON "ActivityLog"("customer_id");

-- CreateIndex
CREATE INDEX "ActivityLog_action_resource_type_idx" ON "ActivityLog"("action", "resource_type");

-- CreateIndex
CREATE INDEX "ActivityLog_resource_type_resource_id_idx" ON "ActivityLog"("resource_type", "resource_id");

-- CreateIndex
CREATE INDEX "ActivityLog_created_at_idx" ON "ActivityLog"("created_at");

-- CreateIndex
CREATE UNIQUE INDEX "ApiKey_key_hash_key" ON "ApiKey"("key_hash");

-- CreateIndex
CREATE INDEX "ApiKey_key_prefix_idx" ON "ApiKey"("key_prefix");

-- CreateIndex
CREATE INDEX "ApiKey_is_active_idx" ON "ApiKey"("is_active");

-- CreateIndex
CREATE UNIQUE INDEX "SiteSetting_key_key" ON "SiteSetting"("key");

-- CreateIndex
CREATE INDEX "SiteSetting_key_idx" ON "SiteSetting"("key");

-- CreateIndex
CREATE INDEX "SiteSetting_group_idx" ON "SiteSetting"("group");

-- CreateIndex
CREATE INDEX "Address_customer_id_idx" ON "Address"("customer_id");

-- CreateIndex
CREATE INDEX "Address_is_default_idx" ON "Address"("is_default");

-- CreateIndex
CREATE INDEX "Address_country_idx" ON "Address"("country");

-- CreateIndex
CREATE INDEX "ContactSubmission_is_read_idx" ON "ContactSubmission"("is_read");

-- CreateIndex
CREATE INDEX "ContactSubmission_created_at_idx" ON "ContactSubmission"("created_at");

-- AddForeignKey
ALTER TABLE "Admin" ADD CONSTRAINT "Admin_avatar_id_fkey" FOREIGN KEY ("avatar_id") REFERENCES "Media"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "AdminSession" ADD CONSTRAINT "AdminSession_admin_id_fkey" FOREIGN KEY ("admin_id") REFERENCES "Admin"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Customer" ADD CONSTRAINT "Customer_avatar_id_fkey" FOREIGN KEY ("avatar_id") REFERENCES "Media"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Customer" ADD CONSTRAINT "Customer_group_id_fkey" FOREIGN KEY ("group_id") REFERENCES "CustomerGroup"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "MediaFolder" ADD CONSTRAINT "MediaFolder_parent_id_fkey" FOREIGN KEY ("parent_id") REFERENCES "MediaFolder"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "MediaFolder" ADD CONSTRAINT "MediaFolder_cover_id_fkey" FOREIGN KEY ("cover_id") REFERENCES "Media"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Media" ADD CONSTRAINT "Media_folder_id_fkey" FOREIGN KEY ("folder_id") REFERENCES "MediaFolder"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Media" ADD CONSTRAINT "Media_uploaded_by_id_fkey" FOREIGN KEY ("uploaded_by_id") REFERENCES "Admin"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "MediaUsage" ADD CONSTRAINT "MediaUsage_media_id_fkey" FOREIGN KEY ("media_id") REFERENCES "Media"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Category" ADD CONSTRAINT "Category_parent_id_fkey" FOREIGN KEY ("parent_id") REFERENCES "Category"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CategoryMedia" ADD CONSTRAINT "CategoryMedia_category_id_fkey" FOREIGN KEY ("category_id") REFERENCES "Category"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CategoryMedia" ADD CONSTRAINT "CategoryMedia_media_id_fkey" FOREIGN KEY ("media_id") REFERENCES "Media"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Brand" ADD CONSTRAINT "Brand_logo_id_fkey" FOREIGN KEY ("logo_id") REFERENCES "Media"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ProductTag" ADD CONSTRAINT "ProductTag_product_id_fkey" FOREIGN KEY ("product_id") REFERENCES "Product"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ProductTag" ADD CONSTRAINT "ProductTag_tag_id_fkey" FOREIGN KEY ("tag_id") REFERENCES "Tag"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Product" ADD CONSTRAINT "Product_category_id_fkey" FOREIGN KEY ("category_id") REFERENCES "Category"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Product" ADD CONSTRAINT "Product_brand_id_fkey" FOREIGN KEY ("brand_id") REFERENCES "Brand"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Product" ADD CONSTRAINT "Product_tax_class_id_fkey" FOREIGN KEY ("tax_class_id") REFERENCES "TaxClass"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Product" ADD CONSTRAINT "Product_og_image_id_fkey" FOREIGN KEY ("og_image_id") REFERENCES "Media"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ProductMedia" ADD CONSTRAINT "ProductMedia_product_id_fkey" FOREIGN KEY ("product_id") REFERENCES "Product"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ProductMedia" ADD CONSTRAINT "ProductMedia_media_id_fkey" FOREIGN KEY ("media_id") REFERENCES "Media"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ProductMedia" ADD CONSTRAINT "ProductMedia_variant_id_fkey" FOREIGN KEY ("variant_id") REFERENCES "ProductVariant"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ProductOption" ADD CONSTRAINT "ProductOption_product_id_fkey" FOREIGN KEY ("product_id") REFERENCES "Product"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ProductOptionValue" ADD CONSTRAINT "ProductOptionValue_option_id_fkey" FOREIGN KEY ("option_id") REFERENCES "ProductOption"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ProductOptionValue" ADD CONSTRAINT "ProductOptionValue_media_id_fkey" FOREIGN KEY ("media_id") REFERENCES "Media"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ProductVariant" ADD CONSTRAINT "ProductVariant_product_id_fkey" FOREIGN KEY ("product_id") REFERENCES "Product"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "VariantOptionValue" ADD CONSTRAINT "VariantOptionValue_variant_id_fkey" FOREIGN KEY ("variant_id") REFERENCES "ProductVariant"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "VariantOptionValue" ADD CONSTRAINT "VariantOptionValue_option_value_id_fkey" FOREIGN KEY ("option_value_id") REFERENCES "ProductOptionValue"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ProductAttribute" ADD CONSTRAINT "ProductAttribute_product_id_fkey" FOREIGN KEY ("product_id") REFERENCES "Product"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ProductRelation" ADD CONSTRAINT "ProductRelation_product_id_fkey" FOREIGN KEY ("product_id") REFERENCES "Product"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ProductRelation" ADD CONSTRAINT "ProductRelation_related_id_fkey" FOREIGN KEY ("related_id") REFERENCES "Product"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ProductPrice" ADD CONSTRAINT "ProductPrice_pricelist_id_fkey" FOREIGN KEY ("pricelist_id") REFERENCES "PriceList"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ProductPrice" ADD CONSTRAINT "ProductPrice_product_id_fkey" FOREIGN KEY ("product_id") REFERENCES "Product"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ProductPrice" ADD CONSTRAINT "ProductPrice_variant_id_fkey" FOREIGN KEY ("variant_id") REFERENCES "ProductVariant"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "TaxRate" ADD CONSTRAINT "TaxRate_tax_class_id_fkey" FOREIGN KEY ("tax_class_id") REFERENCES "TaxClass"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ShippingMethod" ADD CONSTRAINT "ShippingMethod_zone_id_fkey" FOREIGN KEY ("zone_id") REFERENCES "ShippingZone"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "WarehouseStock" ADD CONSTRAINT "WarehouseStock_warehouse_id_fkey" FOREIGN KEY ("warehouse_id") REFERENCES "Warehouse"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "WarehouseStock" ADD CONSTRAINT "WarehouseStock_product_id_fkey" FOREIGN KEY ("product_id") REFERENCES "Product"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "WarehouseStock" ADD CONSTRAINT "WarehouseStock_variant_id_fkey" FOREIGN KEY ("variant_id") REFERENCES "ProductVariant"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Review" ADD CONSTRAINT "Review_product_id_fkey" FOREIGN KEY ("product_id") REFERENCES "Product"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Review" ADD CONSTRAINT "Review_customer_id_fkey" FOREIGN KEY ("customer_id") REFERENCES "Customer"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ReviewMedia" ADD CONSTRAINT "ReviewMedia_review_id_fkey" FOREIGN KEY ("review_id") REFERENCES "Review"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ReviewMedia" ADD CONSTRAINT "ReviewMedia_media_id_fkey" FOREIGN KEY ("media_id") REFERENCES "Media"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ReviewHelpful" ADD CONSTRAINT "ReviewHelpful_review_id_fkey" FOREIGN KEY ("review_id") REFERENCES "Review"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ReviewHelpful" ADD CONSTRAINT "ReviewHelpful_customer_id_fkey" FOREIGN KEY ("customer_id") REFERENCES "Customer"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "WishlistItem" ADD CONSTRAINT "WishlistItem_customer_id_fkey" FOREIGN KEY ("customer_id") REFERENCES "Customer"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "WishlistItem" ADD CONSTRAINT "WishlistItem_product_id_fkey" FOREIGN KEY ("product_id") REFERENCES "Product"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CartItem" ADD CONSTRAINT "CartItem_customer_id_fkey" FOREIGN KEY ("customer_id") REFERENCES "Customer"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CartItem" ADD CONSTRAINT "CartItem_product_id_fkey" FOREIGN KEY ("product_id") REFERENCES "Product"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CartItem" ADD CONSTRAINT "CartItem_variant_id_fkey" FOREIGN KEY ("variant_id") REFERENCES "ProductVariant"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CouponProduct" ADD CONSTRAINT "CouponProduct_coupon_id_fkey" FOREIGN KEY ("coupon_id") REFERENCES "Coupon"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CouponProduct" ADD CONSTRAINT "CouponProduct_product_id_fkey" FOREIGN KEY ("product_id") REFERENCES "Product"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CouponUsage" ADD CONSTRAINT "CouponUsage_coupon_id_fkey" FOREIGN KEY ("coupon_id") REFERENCES "Coupon"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CouponUsage" ADD CONSTRAINT "CouponUsage_customer_id_fkey" FOREIGN KEY ("customer_id") REFERENCES "Customer"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CouponUsage" ADD CONSTRAINT "CouponUsage_order_id_fkey" FOREIGN KEY ("order_id") REFERENCES "Order"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Order" ADD CONSTRAINT "Order_customer_id_fkey" FOREIGN KEY ("customer_id") REFERENCES "Customer"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Order" ADD CONSTRAINT "Order_shipping_address_id_fkey" FOREIGN KEY ("shipping_address_id") REFERENCES "Address"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Order" ADD CONSTRAINT "Order_billing_address_id_fkey" FOREIGN KEY ("billing_address_id") REFERENCES "Address"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Order" ADD CONSTRAINT "Order_shipping_zone_id_fkey" FOREIGN KEY ("shipping_zone_id") REFERENCES "ShippingZone"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Order" ADD CONSTRAINT "Order_shipping_method_id_fkey" FOREIGN KEY ("shipping_method_id") REFERENCES "ShippingMethod"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "OrderItem" ADD CONSTRAINT "OrderItem_order_id_fkey" FOREIGN KEY ("order_id") REFERENCES "Order"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "OrderItem" ADD CONSTRAINT "OrderItem_product_id_fkey" FOREIGN KEY ("product_id") REFERENCES "Product"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "OrderItem" ADD CONSTRAINT "OrderItem_variant_id_fkey" FOREIGN KEY ("variant_id") REFERENCES "ProductVariant"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "OrderStatusHistory" ADD CONSTRAINT "OrderStatusHistory_order_id_fkey" FOREIGN KEY ("order_id") REFERENCES "Order"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PaymentTransaction" ADD CONSTRAINT "PaymentTransaction_order_id_fkey" FOREIGN KEY ("order_id") REFERENCES "Order"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Refund" ADD CONSTRAINT "Refund_return_id_fkey" FOREIGN KEY ("return_id") REFERENCES "Return"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Refund" ADD CONSTRAINT "Refund_payment_id_fkey" FOREIGN KEY ("payment_id") REFERENCES "PaymentTransaction"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Return" ADD CONSTRAINT "Return_order_id_fkey" FOREIGN KEY ("order_id") REFERENCES "Order"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ReturnItem" ADD CONSTRAINT "ReturnItem_return_id_fkey" FOREIGN KEY ("return_id") REFERENCES "Return"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ReturnItem" ADD CONSTRAINT "ReturnItem_order_item_id_fkey" FOREIGN KEY ("order_item_id") REFERENCES "OrderItem"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "InventoryLog" ADD CONSTRAINT "InventoryLog_product_id_fkey" FOREIGN KEY ("product_id") REFERENCES "Product"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "InventoryLog" ADD CONSTRAINT "InventoryLog_variant_id_fkey" FOREIGN KEY ("variant_id") REFERENCES "ProductVariant"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "InventoryLog" ADD CONSTRAINT "InventoryLog_warehouse_id_fkey" FOREIGN KEY ("warehouse_id") REFERENCES "Warehouse"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Page" ADD CONSTRAINT "Page_og_image_id_fkey" FOREIGN KEY ("og_image_id") REFERENCES "Media"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Banner" ADD CONSTRAINT "Banner_image_id_fkey" FOREIGN KEY ("image_id") REFERENCES "Media"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Banner" ADD CONSTRAINT "Banner_mobile_image_id_fkey" FOREIGN KEY ("mobile_image_id") REFERENCES "Media"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Redirect" ADD CONSTRAINT "Redirect_image_id_fkey" FOREIGN KEY ("image_id") REFERENCES "Media"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Notification" ADD CONSTRAINT "Notification_template_id_fkey" FOREIGN KEY ("template_id") REFERENCES "NotificationTemplate"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Notification" ADD CONSTRAINT "Notification_admin_id_fkey" FOREIGN KEY ("admin_id") REFERENCES "Admin"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Notification" ADD CONSTRAINT "Notification_customer_id_fkey" FOREIGN KEY ("customer_id") REFERENCES "Customer"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Notification" ADD CONSTRAINT "Notification_order_id_fkey" FOREIGN KEY ("order_id") REFERENCES "Order"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ActivityLog" ADD CONSTRAINT "ActivityLog_admin_id_fkey" FOREIGN KEY ("admin_id") REFERENCES "Admin"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ActivityLog" ADD CONSTRAINT "ActivityLog_customer_id_fkey" FOREIGN KEY ("customer_id") REFERENCES "Customer"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SiteSetting" ADD CONSTRAINT "SiteSetting_image_id_fkey" FOREIGN KEY ("image_id") REFERENCES "Media"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Address" ADD CONSTRAINT "Address_customer_id_fkey" FOREIGN KEY ("customer_id") REFERENCES "Customer"("id") ON DELETE CASCADE ON UPDATE CASCADE;

