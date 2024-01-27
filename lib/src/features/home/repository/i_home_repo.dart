import 'package:auto_cart/src/features/home/models/category.dart';
import 'package:auto_cart/src/features/home/models/product.dart';

abstract interface class IHomeRepository {
  Future<List<ProductCategory>> getCategories();
  Future<List<Product>> getProducts();
}
