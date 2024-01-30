import 'package:auto_cart/src/features/home/logic/product/product_provider.dart';
import 'package:auto_cart/src/features/home/models/product.dart';
import 'package:auto_cart/src/features/home/widgets/product/product_card.dart';
import 'package:auto_cart/src/shared/utils/pagination/pagination_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AllProductSection extends ConsumerStatefulWidget {
  const AllProductSection({
    super.key,
  });

  @override
  ConsumerState<AllProductSection> createState() => _AllProductSectionState();
}

class _AllProductSectionState extends ConsumerState<AllProductSection> {
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      double maxScroll = scrollController.position.maxScrollExtent;
      double currentScroll = scrollController.position.pixels;
      double delta = MediaQuery.of(context).size.width * 0.20;
      if (maxScroll - currentScroll <= delta &&
          ref.read(productProvider.notifier).canLoadMore()) {
        final currentLoadingType = ref.watch(currentLoadingTypeProvider);
        ref.read(productProvider.notifier).loadMore(currentLoadingType);
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AsyncValue<PaginationResponse<Product>> products =
        ref.watch(productProvider);
    final controller = ref.read(productProvider.notifier);
    return Expanded(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Featured Products',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                products.when(
                  data: (data) => Text('${data.data.length} results'),
                  error: (error, stackTrace) => const SizedBox.shrink(),
                  loading: () => const SizedBox.shrink(),
                ),
              ],
            ),
          ),
          Expanded(
            child: products.when(
              data: (data) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.33,
                    child: GridView.builder(
                        controller: scrollController,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 0.7,
                        ),
                        itemCount: data.data.length +
                            (products.isLoading ||
                                    products.hasError ||
                                    !controller.canLoadMore()
                                ? 1
                                : 0),
                        itemBuilder: (context, index) {
                          if (data.data.length == index) {
                            if (products.isLoading) {
                              return const Center(
                                  child: CircularProgressIndicator.adaptive());
                            }
                            if (products.hasError) {
                              return Center(
                                  child: Text(products.error.toString()));
                            }
                            if (!controller.canLoadMore()) {
                              return const Center(child: Text("No more data"));
                            }
                          }
                          final product = data.data[index];
                          return ProductCard(product: product);
                        }),
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
          ),
        ],
      ),
    );
  }
}
