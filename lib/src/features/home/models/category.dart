class ProductCategory {
  final int id;
  final String categoryName;
  final int? catId;
  final String? image;
  final String? createdAt;
  final String? updatedAt;
  final int? status;

  const ProductCategory({
    required this.id,
    required this.categoryName,
    this.catId,
    this.image,
    this.createdAt,
    this.updatedAt,
    this.status,
  });

  ProductCategory.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        categoryName = json['category_name'],
        catId = json['cat_id'],
        image = json['image'],
        createdAt = json['created_at'],
        updatedAt = json['updated_at'],
        status = json['status'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['category_name'] = categoryName;
    data['cat_id'] = catId;
    data['image'] = image;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['status'] = status;
    return data;
  }
}
