import 'package:auto_cart/src/features/home/models/category.dart';

abstract interface class IHomeRepository {
  Future<List<ProductCategory>> getCategories();
  // Future<List<Product>> getProducts();
}
