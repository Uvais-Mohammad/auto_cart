import 'package:auto_cart/src/features/home/logic/product/product_provider.dart';
import 'package:auto_cart/src/features/home/models/product.dart';
import 'package:auto_cart/src/features/home/screens/products/product_screen.dart';
import 'package:auto_cart/src/features/home/widgets/product/product_card.dart';
import 'package:auto_cart/src/shared/extensions/navigation_extensions.dart';
import 'package:auto_cart/src/shared/utils/pagination/pagination_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FeaturedProductSection extends ConsumerWidget {
  const FeaturedProductSection({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<PaginationResponse<Product>> products =
        ref.watch(productProvider);
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 14),
                child: Text(
                  'Featured Products',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: TextButton(
                  onPressed: () {
                    context.push(const ProductScreen());
                  },
                  child: const Text(
                    'View All',
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ],
          ),
          products.when(
            data: (data) {
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 0.7,
                    ),
                    itemCount: 6,
                    itemBuilder: (context, index) =>
                        ProductCard(product: data.data[index]),
                  ),
                ),
              );
            },
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
            error: (error, stackTrace) => Center(
              child: Text(error.toString()),
            ),
          ),
        ],
      ),
    );
  }
}
