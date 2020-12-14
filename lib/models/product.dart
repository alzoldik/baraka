class Product {
  int id;
  String type,
      name,
      urlKey,
      shortDescription,
      description,
      sku,
      priceAfterDiscountFormatted,
      priceBeforeDiscountFormatted;
  List<ProductImage> images;
  BaseImage baseImage;
  List<dynamic> variants;
  ProductReview reviews;
  bool isSaved, isFavourite, inStock, isWaiting;
  DateTime createdAt, updatedAt;
  num quantity, discountPercent, priceAfterDiscount, priceBeforeDiscount;
  Product({
    this.id,
    this.type,
    this.name,
    this.urlKey,
    this.quantity,
    this.discountPercent,
    this.isWaiting = false,
    this.shortDescription,
    this.description,
    this.priceAfterDiscountFormatted,
    this.priceBeforeDiscountFormatted,
    this.priceAfterDiscount,
    this.priceBeforeDiscount,
    this.sku,
    this.images,
    this.baseImage,
    this.variants,
    this.isFavourite = false,
    this.inStock,
    this.reviews,
    this.isSaved,
    this.createdAt,
    this.updatedAt,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    Iterable imageList = json['images'];
    return Product(
      id: json["id"] ?? null,
      type: json["type"] ?? null,
      name: json["name"] ?? null,
      urlKey: json["url_key"] ?? null,
      quantity: json['quantity'] ?? null,
      shortDescription: json["short_description"] ?? null,
      description: json["description"] ?? null,
      sku: json["sku"] ?? null,
      priceAfterDiscount: json['price_after_discount'] ?? null,
      priceBeforeDiscount: json['price_before_discount'] ?? null,
      priceAfterDiscountFormatted:
          json['price_after_discount_formatted'] ?? null,
      priceBeforeDiscountFormatted:
          json['price_before_discount_formatted'] ?? null,
      discountPercent: json['discount_percent'] ?? 0,
      isFavourite: json['is_favorite'] ?? false,
      images: json['images'] != null
          ? imageList.map((image) => ProductImage.fromJson(image)).toList()
          : [],
      baseImage: json["base_image"] == null
          ? null
          : BaseImage.fromJson(json["base_image"]),
      inStock: json["in_stock"] == null ? false : json["in_stock"],
      reviews: json['reviews'] != null
          ? ProductReview.fromJson(json['reviews'])
          : null,
      isSaved: json["is_saved"] == null ? false : json["is_saved"],
      createdAt: json["created_at"] == null
          ? null
          : DateTime.parse(json["created_at"]),
      updatedAt: json["updated_at"] == null
          ? null
          : DateTime.parse(json["updated_at"]),
    );
  }
}

class BaseImage {
  BaseImage({
    this.smallImageUrl,
    this.mediumImageUrl,
    this.largeImageUrl,
    this.originalImageUrl,
  });

  String smallImageUrl;
  String mediumImageUrl;
  String largeImageUrl;
  String originalImageUrl;

  factory BaseImage.fromJson(Map<String, dynamic> json) => BaseImage(
        smallImageUrl: json["small_image_url"] ?? null,
        mediumImageUrl: json["medium_image_url"] ?? null,
        largeImageUrl: json["large_image_url"] ?? null,
        originalImageUrl: json["original_image_url"] ?? null,
      );
}

class ProductImage {
  ProductImage({
    this.id,
    this.path,
    this.url,
    this.originalImageUrl,
    this.smallImageUrl,
    this.mediumImageUrl,
    this.largeImageUrl,
  });

  int id;
  String path;
  String url;
  String originalImageUrl;
  String smallImageUrl;
  String mediumImageUrl;
  String largeImageUrl;

  factory ProductImage.fromJson(Map<String, dynamic> json) => ProductImage(
        id: json["id"] ?? null,
        path: json["path"] ?? null,
        url: json["url"] ?? null,
        originalImageUrl: json["original_image_url"] ?? null,
        smallImageUrl: json["small_image_url"] ?? null,
        mediumImageUrl: json["medium_image_url"] ?? null,
        largeImageUrl: json["large_image_url"] ?? null,
      );
}

class ProductReview {
  int total;
  dynamic totalRating;
  dynamic averageRating;
  List<dynamic> percentages;
  ProductReview({
    this.total,
    this.totalRating,
    this.averageRating,
    this.percentages,
  });

  factory ProductReview.fromJson(Map<String, dynamic> json) {
    return ProductReview(
      total: json["total"] == null ? null : json["total"],
      totalRating: json["total_rating"],
      averageRating: json["average_rating"],
      percentages: json["percentage"],
    );
  }
}
