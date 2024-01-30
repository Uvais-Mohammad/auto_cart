
class ProductDetail {
  final int id;
  final int brandId;
  final String productName;
  final int offerPrice;
  final int price;
  final String description;
  final int status;
  final int hsncode;
  final int priority;
  final String createdAt;
  final String updatedAt;
  final int catId;
  final List<String> images;

  const ProductDetail({
    required this.id,
    required this.brandId,
    required this.productName,
    required this.offerPrice,
    required this.price,
    required this.description,
    required this.status,
    required this.hsncode,
    required this.priority,
    required this.createdAt,
    required this.updatedAt,
    required this.catId,
    required this.images,
  });

  ProductDetail.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        brandId = json['brand_id'],
        productName = json['product_name'],
        offerPrice = json['offer_price'],
        price = json['price'],
        description = json['description'],
        status = json['status'],
        hsncode = json['hsncode'],
        priority = json['priority'],
        createdAt = json['created_at'],
        updatedAt = json['updated_at'],
        catId = json['cat_id'],
        images = List<String>.from(json['images']);

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
