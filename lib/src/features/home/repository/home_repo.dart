import 'dart:convert';

import 'package:auto_cart/src/features/home/models/brand.dart';
import 'package:auto_cart/src/features/home/models/cart_item.dart';
import 'package:auto_cart/src/features/home/models/category.dart';
import 'package:auto_cart/src/features/home/models/product.dart';
import 'package:auto_cart/src/features/home/models/product_detail.dart';
import 'package:auto_cart/src/features/home/repository/i_home_repo.dart';
import 'package:auto_cart/src/shared/constants/endpoints.dart';
import 'package:auto_cart/src/shared/extensions/string_extensions.dart';
import 'package:auto_cart/src/shared/services/http_service/http_service.dart';
import 'package:auto_cart/src/shared/services/http_service/i_http_service.dart';
import 'package:auto_cart/src/shared/utils/pagination/pagination_response.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final homeRepositoryProvider = Provider<IHomeRepository>(
  (ref) => HomeRepository(
    httpService: ref.read(httpServiceProvider),
  ),
);

final class HomeRepository implements IHomeRepository {
  final IHttpService _httpService;

  HomeRepository({
    required IHttpService httpService,
  }) : _httpService = httpService;

  @override
  Future<List<ProductCategory>> getCategories() async {
    final response = await _httpService.get(
      EndPoints.category.url,
    );
    if (response.statusCode == 200) {
      final List<ProductCategory> categories =
          (jsonDecode(response.body)['categorylist'] as List)
              .map((e) => ProductCategory.fromJson(e))
              .toList();
      categories.insert(
        0,
        const ProductCategory(
          id: 0,
          categoryName: 'All Products',
        ),
      );
      return categories;
    } else {
      throw Exception('Failed to load categories');
    }
  }

  @override
  Future<List<ProductCategory>> getSubCategories(int id) async {
    final response = await _httpService.post(
      EndPoints.subCategory.url,
      body: {
        'cat_id': id,
      },
    );
    if (response.statusCode == 200) {
      final List<ProductCategory> categories =
          (jsonDecode(response.body)['subcategorylist'] as List)
              .map((e) => ProductCategory.fromJson(e))
              .toList();
      categories.insert(
        0,
        const ProductCategory(
          id: 0,
          categoryName: 'All',
        ),
      );
      return categories;
    } else {
      throw Exception('Failed to load sub categories');
    }
  }

  @override
  Future<PaginationResponse<Product>> getProducts(int index) async {
    final response = await _httpService.post(
      EndPoints.product,
      body: {
        'index': index,
      },
    );
    if (response.statusCode == 200) {
      final List<Product> products =
          (jsonDecode(response.body)['product'] as List)
              .map((e) => Product.fromJson(e))
              .toList();
      return PaginationResponse(
        index: index,
        data: products,
        isCompleted: products.isEmpty,
      );
    } else {
      throw Exception('Failed to load products');
    }
  }

  @override
  Future<List<Brand>> getBrands(int subCatId) async {
    final response = await _httpService.post(
      EndPoints.brand,
      body: {
        'subcat_id': subCatId,
      },
    );
    if (response.statusCode == 200) {
      final List<Brand> brands =
          (jsonDecode(response.body)['brandlist'] as List)
              .map((e) => Brand.fromJson(e))
              .toList();
      return brands;
    } else {
      throw Exception('Failed to load brands');
    }
  }

  @override
  Future<PaginationResponse<Product>> getProductBySubCategory(
      {required int index, required int catId}) async {
    final response = await _httpService.post(
      EndPoints.productByCategory,
      body: {
        'index': index,
        'categoryid': catId,
      },
    );
    if (response.statusCode == 200) {
      final List<Product> products =
          (jsonDecode(response.body)['productlist'] as List)
              .map((e) => Product.fromJson(e))
              .toList();
      return PaginationResponse(
        index: index,
        data: products,
        isCompleted: products.isEmpty,
      );
    } else {
      throw Exception('Failed to load products');
    }
  }

  @override
  Future<List<CartItem>> getCartItems(int shopId) async {
    final response = await _httpService.post(
      EndPoints.cart,
      body: {
        'shop_id': shopId,
      },
    );
    if (response.statusCode == 200) {
      final List<CartItem> cartItems =
          (jsonDecode(response.body)['cart'] as List)
              .map((e) => CartItem.fromJson(e))
              .toList();
      return cartItems;
    } else {
      throw Exception('Failed to load cart items');
    }
  }

  @override
  Future<bool> addToCart(
      {required int shopId,
      required int productId,
      required int quantity}) async {
    final response = await _httpService.post(
      EndPoints.addToCart,
      body: {
        'shop_id': shopId,
        'product_id': productId,
        'qty': quantity,
      },
    );
    if (response.statusCode == 200) {
      final res = jsonDecode(response.body);
      if (res['error'] == false) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  @override
  Future<bool> removeFromCart({required int id}) async {
    final response = await _httpService.post(
      EndPoints.removeFromCart,
      body: {
        'id': id,
      },
    );
    if (response.statusCode == 200) {
      final res = jsonDecode(response.body);
      if (res['data'] == 1) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }
  
  @override
  Future<PaginationResponse<Product>> searchProducts({required int index, required String query}) async{
    final response = await _httpService.post(
      EndPoints.searchProduct,
      body: {
        'index': index,
        'productname': query,
      },
    );
    if (response.statusCode == 200) {
      final List<Product> products =
          (jsonDecode(response.body)['product'] as List)
              .map((e) => Product.fromJson(e))
              .toList();
      return PaginationResponse(
        index: index,
        data: products,
        isCompleted: products.isEmpty,
      );
    } else {
      throw Exception('Failed to load products');
    }
  }
  
  @override
  Future<PaginationResponse<Product>> getProductsByBrand({required int index, required int brandId})async {
    final response = await _httpService.post(
      EndPoints.brandFilter,
      body: {
        'index': index,
        'brand_id': brandId,
      },
    );
    if (response.statusCode == 200) {
      final List<Product> products =
          (jsonDecode(response.body)['product'] as List)
              .map((e) => Product.fromJson(e))
              .toList();
      return PaginationResponse(
        index: index,
        data: products,
        isCompleted: products.isEmpty,
      );
    } else {
      throw Exception('Failed to load products');
    }
  }

  @override
  Future<ProductDetail> getProductDetail(int id) async{
    final response = await _httpService.post(
      EndPoints.productDetails,
      body: {
        'productid': id,
      },
    );
    if (response.statusCode == 200) {
      final productDetail = ProductDetail.fromJson(jsonDecode(response.body)['productdetails'].first);
      return productDetail;
    } else {
      throw Exception('Failed to load product detail');
    }
  }
}
