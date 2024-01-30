import 'dart:async';

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

class SubCategoryProvider extends AsyncNotifier<List<ProductCategory>> {
  @override
  Future<List<ProductCategory>> build() async {
    final catId = ref.read(selectedCategoryProvider.notifier).state.id;
    return await _loadData(catId);
  }

  FutureOr<List<ProductCategory>> _loadData(int index) {
    //reset sub category when category changes to all products
    ref.read(selectedSubCategoryProvider.notifier).state =
        const ProductCategory(
      id: 0,
      categoryName: 'All',
    );
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
