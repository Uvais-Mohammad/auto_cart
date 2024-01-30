import 'dart:async';

import 'package:auto_cart/src/features/home/logic/brand/brand_providers.dart';
import 'package:auto_cart/src/features/home/logic/category/category_provider.dart';
import 'package:auto_cart/src/features/home/models/product.dart';
import 'package:auto_cart/src/features/home/models/product_detail.dart';
import 'package:auto_cart/src/features/home/repository/home_repo.dart';
import 'package:auto_cart/src/shared/enums/load_type.dart';
import 'package:auto_cart/src/shared/utils/pagination/pagination_controller.dart';
import 'package:auto_cart/src/shared/utils/pagination/pagination_response.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final productProvider =
    AsyncNotifierProvider<ProductController, PaginationResponse<Product>>(
        ProductController.new);

final currentLoadingTypeProvider = StateProvider<LoadingType>((ref) {
  return LoadingType.initial;
});

final searchQueryProvider = StateProvider<String>((ref) {
  return '';
});

final productDetailProvider = FutureProvider.family<ProductDetail, int>((ref, productId) async {
  return ref.read(homeRepositoryProvider).getProductDetail(productId);
});

class ProductController extends AsyncNotifier<PaginationResponse<Product>>
    with PaginationController<Product> {
  @override
  FutureOr<PaginationResponse<Product>> build() async {
    return await loadData(index: 0);
  }

  @override
  FutureOr<PaginationResponse<Product>> loadData(
      {required int index,
      LoadingType loadingType = LoadingType.initial}) async {
    switch (loadingType) {
      case LoadingType.initial:
        return await ref.read(homeRepositoryProvider).getProducts(index);
      case LoadingType.filteredBySubCategory:
        final catId = ref.read(selectedSubCategoryProvider.notifier).state.id;
        return await ref.read(homeRepositoryProvider).getProductBySubCategory(
              index: index,
              catId: catId,
            );
      case LoadingType.filteredBySearch:
        final searchQuery = ref.read(searchQueryProvider.notifier).state;
        return await ref.read(homeRepositoryProvider).searchProducts(
              index: index,
              query: searchQuery,
            );
      case LoadingType.filteredByBrand:
        final brandId = ref.read(selectedBrandProvider.notifier).state;
        return await ref.read(homeRepositoryProvider).getProductsByBrand(
              index: index,
              brandId: brandId!.id,
            );
    }
  }

  Future<void> filterBySubCategory() async {
    state = const AsyncLoading<PaginationResponse<Product>>();
    final catId = ref.read(selectedSubCategoryProvider.notifier).state.id;
    state = await AsyncValue.guard(
      () async {
        return ref.read(homeRepositoryProvider).getProductBySubCategory(
              index: 0,
              catId: catId,
            );
      },
    );
  }

  Future<void> filterBySearch() async {
    state = const AsyncLoading<PaginationResponse<Product>>();
    final searchQuery = ref.read(searchQueryProvider.notifier).state;
    state = await AsyncValue.guard(
      () async {
        return ref.read(homeRepositoryProvider).searchProducts(
              index: 0,
              query: searchQuery,
            );
      },
    );
  }

  Future<void> filterByBrand() async {
    state = const AsyncLoading<PaginationResponse<Product>>();
    final brandId = ref.read(selectedBrandProvider.notifier).state;
    state = await AsyncValue.guard(
      () async {
        return ref.read(homeRepositoryProvider).getProductsByBrand(
              index: 0,
              brandId: brandId!.id,
            );
      },
    );
  }

  Future<void> refresh() async {
    state = const AsyncLoading<PaginationResponse<Product>>();
    state = await AsyncValue.guard(
      () async {
        return ref.read(homeRepositoryProvider).getProducts(0);
      },
    );
  }
}
