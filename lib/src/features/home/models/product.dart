class Product {
  final int? id;
  final int? brandId;
  final String? productName;
  final int? offerPrice;
  final int? price;
  final String? description;
  final int? status;
  final int? hsncode;
  final int? priority;
  final String? createdAt;
  final String? updatedAt;
  final int? catId;
  final String images;

  const Product({
    this.id,
    this.brandId,
    this.productName,
    this.offerPrice,
    this.price,
    this.description,
    this.status,
    this.hsncode,
    this.priority,
    this.createdAt,
    this.updatedAt,
    this.catId,
    required this.images,
  });

  Product.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        brandId = json['brand_id'] as int?,
        productName = json['product_name'] as String?,
        offerPrice = json['offer_price'] as int?,
        price = json['price'] as int?,
        description = json['description'] as String?,
        status = json['status'] as int?,
        hsncode = json['hsncode'] as int?,
        priority = json['priority'] as int?,
        createdAt = json['created_at'] as String?,
        updatedAt = json['updated_at'] as String?,
        catId = json['cat_id'] as int?,
        images = json['images'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['brand_id'] = brandId;
    data['product_name'] = productName;
    data['offer_price'] = offerPrice;
    data['price'] = price;
    data['description'] = description;
    data['status'] = status;
    data['hsncode'] = hsncode;
    data['priority'] = priority;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['cat_id'] = catId;
    data['images'] = images;
    return data;
  }
}
