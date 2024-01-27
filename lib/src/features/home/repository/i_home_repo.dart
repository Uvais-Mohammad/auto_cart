import 'package:auto_cart/src/features/home/models/brand.dart';
import 'package:auto_cart/src/features/home/models/category.dart';
import 'package:auto_cart/src/features/home/models/product.dart';
import 'package:auto_cart/src/shared/utils/pagination/pagination_response.dart';

abstract interface class IHomeRepository {
  Future<List<ProductCategory>> getCategories();
  Future<List<ProductCategory>> getSubCategories(int id);
  Future<PaginationResponse<Product>> getProducts(int index);
  Future<PaginationResponse<Product>> getProductBySubCategory({required int index,required int catId});
  Future<List<Brand>> getBrands(int subCatId);
}
