import 'package:auto_cart/src/features/home/logic/brand/brand_providers.dart';
import 'package:auto_cart/src/features/home/logic/category/category_provider.dart';
import 'package:auto_cart/src/features/home/logic/product/product_provider.dart';
import 'package:auto_cart/src/features/home/models/category.dart';
import 'package:auto_cart/src/features/home/widgets/category/category_card.dart';
import 'package:auto_cart/src/shared/enums/load_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoryList extends ConsumerWidget {
  const CategoryList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<List<ProductCategory>> categories =
        ref.watch(productCategoryProvider);
    return categories.when(
      data: (data) => Container(
        height: 80,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: data.length,
          itemBuilder: (context, index) => CategoryCard(
            category: data[index],
            isCategoryControlled: true,
            isAllProducts: index == 0,
            onTap: () {
              if (ref.read(subCategoryProvider).isLoading ||
                  ref.read(productProvider).isLoading) {
                return;
              }
              ref.read(selectedCategoryProvider.notifier).state = data[index];
              ref.read(subCategoryProvider.notifier).refresh();
              ref.read(brandProvider.notifier).refresh();
              if (index == 0) {
                ref.read(currentLoadingTypeProvider.notifier).state =
                    LoadingType.initial;
                ref.read(productProvider.notifier).refresh();
              } else {}
            },
          ),
        ),
      ),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
      error: (error, stackTrace) => Center(
        child: Text(error.toString()),
      ),
    );
  }
}
