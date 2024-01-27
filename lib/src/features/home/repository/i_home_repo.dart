import 'package:auto_cart/src/features/home/models/category.dart';
import 'package:auto_cart/src/features/home/models/product.dart';
import 'package:auto_cart/src/shared/utils/pagination/pagination_request.dart';
import 'package:auto_cart/src/shared/utils/pagination/pagination_response.dart';

abstract interface class IHomeRepository {
  Future<List<ProductCategory>> getCategories();
  Future<PaginationResponse<Product>> getProducts(PaginationRequest request);
}
