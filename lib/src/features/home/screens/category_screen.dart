import 'package:auto_cart/src/features/home/logic/category/category_provider.dart';
import 'package:auto_cart/src/features/home/models/category.dart';
import 'package:auto_cart/src/features/home/screens/product_screen.dart';
import 'package:auto_cart/src/features/home/widgets/category/category_card.dart';
import 'package:auto_cart/src/shared/extensions/navigation_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoryScreen extends ConsumerStatefulWidget {
  const CategoryScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends ConsumerState<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    AsyncValue<List<ProductCategory>> categories =
        ref.watch(productCategoryProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Categories'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.favorite_outline),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.shopping_cart_outlined),
          ),
        ],
      ),
      body: categories.when(
        data: (data) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 1.2,
                      ),
                      itemCount: data.length - 1,
                      itemBuilder: (context, index) {
                        return CategoryCard(
                          category: data[index + 1],
                          isAllCategory: true,
                          onTap: () {
                            ref.read(selectedCategoryProvider.notifier).state =
                                data[index + 1];
                            context.push(const ProductScreen());
                          },
                        );
                      }),
                ),
                OutlinedButton(
                  onPressed: () {
                    ref.read(selectedCategoryProvider.notifier).state =
                        data.first;
                    context.push(const ProductScreen());
                  },
                  child: const Text('View All Products'),
                ),
                const Spacer(),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text(error.toString())),
      ),
    );
  }
}
