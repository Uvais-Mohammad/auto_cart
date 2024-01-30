import 'dart:async';

import 'package:auto_cart/src/features/home/logic/category/category_provider.dart';
import 'package:auto_cart/src/features/home/models/brand.dart';
import 'package:auto_cart/src/features/home/repository/home_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
final brandProvider = AsyncNotifierProvider<BrandProvider, List<Brand>>(
    BrandProvider.new);

final selectedBrandProvider = StateProvider<Brand?>((ref) {
  return null;
});

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
    ref.read(selectedBrandProvider.notifier).state = null;
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