import 'package:auto_cart/src/features/home/logic/category/category_provider.dart';
import 'package:auto_cart/src/features/home/models/category.dart';
import 'package:auto_cart/src/features/home/screens/category_screen.dart';
import 'package:auto_cart/src/features/home/screens/products/product_screen.dart';
import 'package:auto_cart/src/features/home/widgets/category/category_card.dart';
import 'package:auto_cart/src/shared/extensions/navigation_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductCategorySection extends ConsumerWidget {
  const ProductCategorySection({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<List<ProductCategory>> categories =
        ref.watch(productCategoryProvider);
    void setCategoryAndNavigateToProductScreen(ProductCategory category) {
      ref.read(selectedCategoryProvider.notifier).state = category;
      context.push(const ProductScreen());
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 14),
          child: Text(
            'Product Categories',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: categories.when(
            data: (data) => Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 90,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 4,
                        itemBuilder: (context, index) {
                          if (index == 0) {
                            return const SizedBox.shrink();
                          }
                          return CategoryCard(
                            category: data[index],
                            onTap: () {
                              setCategoryAndNavigateToProductScreen(
                                  data[index]);
                            },
                          );
                        }),
                  ),
                ),
                //view all button
                SizedBox(
                  height: 90,
                  child: Card(
                    margin: const EdgeInsets.fromLTRB(4, 4, 6, 4),
                    child: InkWell(
                      onTap: () {
                        context.push(const CategoryScreen());
                      },
                      borderRadius: BorderRadius.circular(12),
                      child: const Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                        child: Row(
                          children: [
                            Text(
                              'View All',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Icon(
                              Icons.chevron_right_outlined,
                              size: 18,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stackTrace) => Text(error.toString()),
          ),
        )
      ],
    );
  }
}
