import 'package:auto_cart/src/features/home/logic/category/category_provider.dart';
import 'package:auto_cart/src/features/home/models/category.dart';
import 'package:auto_cart/src/features/home/widgets/category/filter_button.dart';
import 'package:auto_cart/src/features/home/widgets/category/sub_category_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SubCategorySection extends ConsumerWidget {
  const SubCategorySection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<List<ProductCategory>> subCategories =
        ref.watch(subCategoryProvider);
    return subCategories.when(
      data: (data) {
        if (data.isEmpty) {
          return const SizedBox.shrink();
        }
        return Column(
          children: [
            SizedBox(
              height: subCategories.when(
                data: (data) {
                  if (data.isEmpty) {
                    return 0.0;
                  }
                  return 10.0;
                },
                loading: () => 0.0,
                error: (error, stackTrace) => 0.0,
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Text('Shop by subcategory'),
                  SizedBox(width: 20),
                  SubCategoryDropDown()
                ],
              ),
            ),
            const SizedBox(height: 5),
            const FilterButton(),
          ],
        );
      },
      loading: () => const SizedBox.shrink(),
      error: (error, stackTrace) => const SizedBox.shrink(),
    );
  }
}
