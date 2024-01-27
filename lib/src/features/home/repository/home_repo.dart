import 'dart:convert';

import 'package:auto_cart/src/features/home/models/brand.dart';
import 'package:auto_cart/src/features/home/models/category.dart';
import 'package:auto_cart/src/features/home/models/product.dart';
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
      EndPoints.brand.url,
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
  Future<PaginationResponse<Product>> getProductBySubCategory({required int index, required int catId}) async{
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
}
