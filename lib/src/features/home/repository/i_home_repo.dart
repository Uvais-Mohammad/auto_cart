import 'package:auto_cart/src/features/home/models/brand.dart';
import 'package:auto_cart/src/features/home/models/cart_item.dart';
import 'package:auto_cart/src/features/home/models/category.dart';
import 'package:auto_cart/src/features/home/models/product.dart';
import 'package:auto_cart/src/features/home/models/product_detail.dart';
import 'package:auto_cart/src/shared/utils/pagination/pagination_response.dart';

abstract interface class IHomeRepository {
  Future<List<ProductCategory>> getCategories();
  Future<List<ProductCategory>> getSubCategories(int id);
  Future<PaginationResponse<Product>> getProducts(int index);
  Future<PaginationResponse<Product>> getProductBySubCategory({required int index,required int catId});
  Future<PaginationResponse<Product>> searchProducts({required int index,required String query});
  Future<PaginationResponse<Product>> getProductsByBrand({required int index,required int brandId});
  Future<ProductDetail> getProductDetail(int id);
  Future<List<CartItem>> getCartItems(int shopId);
  Future<bool> addToCart({required int shopId,required int productId,required int quantity});
  Future<bool> removeFromCart({required int id});
  Future<List<Brand>> getBrands(int subCatId);
}
