class Product {
  final int productId;
  final String productName;
  final String productTitle;
  final String productPartCode;
  final String productDataSheet;
  final String productDescription;
  final int categoryId;
  final int manufacturerId;
  final String manufacturer;
  final String manufacturerPartNumber;
  final String manufacturerDescription;
  final String? saPartNumber;
  final String hsnCode;
  final String uomCode;
  final String countryOfOrigin;
  final String factoryLeadTime;
  final String? svhc;
  final double price;
  final double discount;
  final double unitPrice;
  final double todayDealDiscount;
  final double todayDealPrice;
  final String weight;
  final int stockCount;
  final int status;
  final bool isGrabTheDeal;
  final bool isFeatured;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<Variant> variants;
  final List<ProductImage> productImages;
  final ManufacturerDetails manufacturerDetails;
  final List<Category> categories;

  Product({
    required this.productId,
    required this.productName,
    required this.productTitle,
    required this.productPartCode,
    required this.productDataSheet,
    required this.productDescription,
    required this.categoryId,
    required this.manufacturerId,
    required this.manufacturer,
    required this.manufacturerPartNumber,
    required this.manufacturerDescription,
    this.saPartNumber,
    required this.hsnCode,
    required this.uomCode,
    required this.countryOfOrigin,
    required this.factoryLeadTime,
    this.svhc,
    required this.price,
    required this.discount,
    required this.unitPrice,
    required this.todayDealDiscount,
    required this.todayDealPrice,
    required this.weight,
    required this.stockCount,
    required this.status,
    required this.isGrabTheDeal,
    required this.isFeatured,
    required this.createdAt,
    required this.updatedAt,
    required this.variants,
    required this.productImages,
    required this.manufacturerDetails,
    required this.categories,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      productId: json['product_id'],
      productName: json['product_name'],
      productTitle: json['product_title'],
      productPartCode: json['product_part_code'],
      productDataSheet: json['product_data_sheet'],
      productDescription: json['product_description'],
      categoryId: json['category_id'],
      manufacturerId: json['manufacturer_id'],
      manufacturer: json['manufacturer'],
      manufacturerPartNumber: json['manufacturer_part_number'],
      manufacturerDescription: json['manufacturer_description'],
      saPartNumber: json['sa_part_number'],
      hsnCode: json['hsn_code'],
      uomCode: json['uom_code'],
      countryOfOrigin: json['country_of_origin'],
      factoryLeadTime: json['factory_lead_time'],
      svhc: json['svhc'],
      price: json['price']?.toDouble() ?? 0.0,
      discount: json['discount']?.toDouble() ?? 0.0,
      unitPrice: json['unit_price']?.toDouble() ?? 0.0,
      todayDealDiscount: json['today_deal_discount']?.toDouble() ?? 0.0,
      todayDealPrice: json['today_deal_price']?.toDouble() ?? 0.0,
      weight: json['weight'],
      stockCount: json['stock_count'],
      status: json['status'],
      isGrabTheDeal: json['is_grab_the_deal'],
      isFeatured: json['is_featured'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      variants:
          (json['variant'] as List).map((v) => Variant.fromJson(v)).toList(),
      productImages: (json['product_images'] as List)
          .map((img) => ProductImage.fromJson(img))
          .toList(),
      manufacturerDetails:
          ManufacturerDetails.fromJson(json['manufacturer_details']),
      categories: (json['categories'] as List)
          .map((c) => Category.fromJson(c))
          .toList(),
    );
  }
}

class Variant {
  final int variantId;
  final int productId;
  final String variantName;
  final String variantValue;
  final DateTime createdAt;
  final DateTime updatedAt;

  Variant({
    required this.variantId,
    required this.productId,
    required this.variantName,
    required this.variantValue,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Variant.fromJson(Map<String, dynamic> json) {
    return Variant(
      variantId: json['variant_id'],
      productId: json['product_id'],
      variantName: json['variant_name'],
      variantValue: json['variant_value'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}

class ProductImage {
  final int productImageId;
  final int productId;
  final String productImage;
  final DateTime createdAt;
  final DateTime updatedAt;

  ProductImage({
    required this.productImageId,
    required this.productId,
    required this.productImage,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ProductImage.fromJson(Map<String, dynamic> json) {
    return ProductImage(
      productImageId: json['product_image_id'],
      productId: json['product_id'],
      productImage: json['product_image'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}

class ManufacturerDetails {
  final int manufacturerId;
  final String manufacturerName;
  final String? manufacturerImage;
  final String? manufacturerDescription;
  final int manufacturerStatus;
  final DateTime createdAt;
  final DateTime updatedAt;

  ManufacturerDetails({
    required this.manufacturerId,
    required this.manufacturerName,
    this.manufacturerImage,
    this.manufacturerDescription,
    required this.manufacturerStatus,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ManufacturerDetails.fromJson(Map<String, dynamic> json) {
    return ManufacturerDetails(
      manufacturerId: json['manufacturer_id'],
      manufacturerName: json['manufacturer_name'],
      manufacturerImage: json['manufacturer_image'],
      manufacturerDescription: json['manufacturer_description'],
      manufacturerStatus: json['manufacturer_status'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}

class Category {
  final int categoryId;
  final int parentId;
  final String categoryName;
  final String? categoryImage;
  final int categoryLevel;
  final DateTime createdAt;
  final DateTime updatedAt;

  Category({
    required this.categoryId,
    required this.parentId,
    required this.categoryName,
    this.categoryImage,
    required this.categoryLevel,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      categoryId: json['category_id'],
      parentId: json['parent_id'] ?? 0,
      categoryName: json['category_name'],
      categoryImage: json['category_image'],
      categoryLevel: json['category_level'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}
