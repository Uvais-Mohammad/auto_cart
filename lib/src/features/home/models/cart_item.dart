class CartItem {
  final int id;
  final int shopId;
  final int productId;
  final int qty;
  final String createdAt;
  final String updatedAt;
  final int offerPrice;
  final int price;
  final String productName;
  final String description;
  final String images;

  const CartItem({
    required this.id,
    required this.shopId,
    required this.productId,
    required this.qty,
    required this.createdAt,
    required this.updatedAt,
    required this.offerPrice,
    required this.price,
    required this.productName,
    required this.description,
    required this.images,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['id'],
      shopId: json['shop_id'],
      productId: json['product_id'],
      qty: json['qty'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      offerPrice: json['offer_price'],
      price: json['price'],
      productName: json['product_name'],
      description: json['description'],
      images: json['images'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['shop_id'] = shopId;
    data['product_id'] = productId;
    data['qty'] = qty;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['offer_price'] = offerPrice;
    data['price'] = price;
    data['product_name'] = productName;
    data['description'] = description;
    data['images'] = images;
    return data;
  }

  CartItem copyWith({
    int? id,
    int? shopId,
    int? productId,
    int? qty,
    String? createdAt,
    String? updatedAt,
    int? offerPrice,
    int? price,
    String? productName,
    String? description,
    String? images,
  }) {
    return CartItem(
      id: id ?? this.id,
      shopId: shopId ?? this.shopId,
      productId: productId ?? this.productId,
      qty: qty ?? this.qty,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      offerPrice: offerPrice ?? this.offerPrice,
      price: price ?? this.price,
      productName: productName ?? this.productName,
      description: description ?? this.description,
      images: images ?? this.images,
    );
  }
}
