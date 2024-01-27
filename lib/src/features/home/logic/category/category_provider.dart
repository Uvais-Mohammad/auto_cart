import 'dart:async';

import 'package:auto_cart/src/features/home/models/brand.dart';
import 'package:auto_cart/src/features/home/models/category.dart';
import 'package:auto_cart/src/features/home/repository/home_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final productCategoryProvider =
    FutureProvider<List<ProductCategory>>((ref) async {
  return ref.read(homeRepositoryProvider).getCategories();
});

final selectedCategoryProvider = StateProvider<ProductCategory>((ref) {
  return const ProductCategory(
    id: 0,
    categoryName: 'All Products',
  );
});

final subCategoryProvider =
    AsyncNotifierProvider<SubCategoryProvider, List<ProductCategory>>(
        SubCategoryProvider.new);

final selectedSubCategoryProvider = StateProvider<ProductCategory>((ref) {
  return const ProductCategory(
    id: 0,
    categoryName: 'All',
  );
});

final brandProvider = AsyncNotifierProvider<BrandProvider, List<Brand>>(
    BrandProvider.new);

final selectedBrandProvider = StateProvider<List<Brand>>((ref) {
  return [];
});

class SubCategoryProvider extends AsyncNotifier<List<ProductCategory>> {
  @override
  Future<List<ProductCategory>> build() async {
    final catId = ref.read(selectedCategoryProvider.notifier).state.id;
    return await _loadData(catId);
  }

  FutureOr<List<ProductCategory>> _loadData(int index) {
    if (index == 0) {
      return [];
    }
    return ref.read(homeRepositoryProvider).getSubCategories(index);
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () async {
        final catId = ref.read(selectedCategoryProvider.notifier).state.id;
        return _loadData(catId);
      },
    );
  }
}

class BrandProvider extends AsyncNotifier<List<Brand>> {
  @override
  Future<List<Brand>> build() async {
    final subCatId = ref.read(selectedSubCategoryProvider.notifier).state.id;
    return await _loadData(subCatId);
  }

  FutureOr<List<Brand>> _loadData(int subCatId) {
    return ref.read(homeRepositoryProvider).getBrands(subCatId);
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () async {
        final subCatId =
            ref.read(selectedSubCategoryProvider.notifier).state.id;
        return _loadData(subCatId);
      },
    );
  }
}
