import 'package:auto_cart/src/features/home/models/category.dart';
import 'package:auto_cart/src/features/home/repository/home_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final productCategoryProvider =
    FutureProvider<List<ProductCategory>>((ref) async {
  return ref.read(homeRepositoryProvider).getCategories();
});

final selectedCategoryProvider = StateProvider<ProductCategory?>((ref) {
  return null;
});
