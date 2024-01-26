import 'dart:convert';

import 'package:auto_cart/src/features/home/models/category.dart';
import 'package:auto_cart/src/features/home/repository/i_home_repo.dart';
import 'package:auto_cart/src/shared/constants/endpoints.dart';
import 'package:auto_cart/src/shared/extensions/string_extensions.dart';
import 'package:auto_cart/src/shared/services/http_service/http_servide.dart';
import 'package:auto_cart/src/shared/services/http_service/i_http_service.dart';
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
      return categories;
    } else {
      throw Exception('Failed to load categories');
    }
  }
}
