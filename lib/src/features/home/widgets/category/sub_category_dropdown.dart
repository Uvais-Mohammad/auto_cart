import 'package:auto_cart/src/features/home/logic/brand/brand_providers.dart';
import 'package:auto_cart/src/features/home/logic/category/category_provider.dart';
import 'package:auto_cart/src/features/home/logic/product/product_provider.dart';
import 'package:auto_cart/src/features/home/models/category.dart';
import 'package:auto_cart/src/shared/enums/load_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SubCategoryDropDown extends ConsumerWidget {
  const SubCategoryDropDown({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<List<ProductCategory>> subCategories =
        ref.watch(subCategoryProvider);
    return subCategories.when(
      data: (data) => Expanded(
        child: SizedBox(
          height: 35,
          child: InputDecorator(
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.zero,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(4.0)),
              ),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<ProductCategory>(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                borderRadius: BorderRadius.circular(4),
                value: ref.watch(selectedSubCategoryProvider),
                onChanged: (value) {
                  ref.read(selectedSubCategoryProvider.notifier).state = value!;
                  ref.read(currentLoadingTypeProvider.notifier).state =
                      LoadingType.filteredBySubCategory;

                  if (value.id != 0) {
                    ref.read(productProvider.notifier).filterBySubCategory();
                    ref.read(brandProvider.notifier).refresh();
                  }
                },
                items: data
                    .map(
                      (e) => DropdownMenuItem<ProductCategory>(
                        value: e,
                        child: Text(e.categoryName),
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
        ),
      ),
      loading: () => const SizedBox.shrink(),
      error: (error, stackTrace) => const SizedBox.shrink(),
    );
  }
}
