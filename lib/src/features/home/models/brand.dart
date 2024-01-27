class Brand {
  final int id;
  final int catId;
  final String brandName;
  final int status;
  final int vendorId;
  final String createdAt;
  final String updatedAt;

  Brand({
    required this.id,
    required this.catId,
    required this.brandName,
    required this.status,
    required this.vendorId,
    required this.createdAt,
    required this.updatedAt,
  });

  Brand.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int,
        catId = json['cat_id'] as int,
        brandName = json['brand_name'] as String,
        status = json['status'] as int,
        vendorId = json['vendor_id'] as int,
        createdAt = json['created_at'] as String,
        updatedAt = json['updated_at'] as String;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['cat_id'] = catId;
    data['brand_name'] = brandName;
    data['status'] = status;
    data['vendor_id'] = vendorId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
