class Category {
  int id, status;
  dynamic code;
  String name,
      slug,
      displayMode,
      description,
      metaTitle,
      metaDescription,
      metaKeywords,
      imageUrl;
  Category({
    this.id,
    this.code,
    this.name,
    this.slug,
    this.displayMode,
    this.description,
    this.metaTitle,
    this.metaDescription,
    this.metaKeywords,
    this.status,
    this.imageUrl,
  });

  factory Category.fromJson(json) {
    return Category(
      id: json["id"] ?? null,
      code: json["code"],
      name: json["name"] ?? null,
      slug: json["slug"] ?? null,
      displayMode: json["display_mode"] ?? null,
      description: json["description"] ?? null,
      metaTitle: json["meta_title"] ?? null,
      metaDescription: json["meta_description"] ?? null,
      metaKeywords: json["meta_keywords"] ?? null,
      status: json["status"] ?? null,
      imageUrl: json["image_url"] ?? null,
    );
  }
}
