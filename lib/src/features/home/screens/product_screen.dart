import 'package:auto_cart/src/features/home/logic/category/category_provider.dart';
import 'package:auto_cart/src/features/home/logic/product/product_provider.dart';
import 'package:auto_cart/src/features/home/models/brand.dart';
import 'package:auto_cart/src/features/home/models/category.dart';
import 'package:auto_cart/src/features/home/models/product.dart';
import 'package:auto_cart/src/features/home/widgets/category/category_card.dart';
import 'package:auto_cart/src/features/home/widgets/product/product_card.dart';
import 'package:auto_cart/src/shared/enums/load_type.dart';
import 'package:auto_cart/src/shared/utils/pagination/pagination_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductScreen extends ConsumerStatefulWidget {
  const ProductScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProductScreenState();
}

class _ProductScreenState extends ConsumerState<ProductScreen> {
  final scrollController = ScrollController();
  final searchController = TextEditingController();

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
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AsyncValue<List<ProductCategory>> categories =
        ref.watch(productCategoryProvider);
    AsyncValue<List<ProductCategory>> subCategories =
        ref.watch(subCategoryProvider);
    AsyncValue<PaginationResponse<Product>> products =
        ref.watch(productProvider);
    AsyncValue<List<Brand>> brands = ref.watch(brandProvider);
    final controller = ref.read(productProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Featured Products'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.favorite_border),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.shopping_cart_outlined),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            height: 40,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TextField(
              controller: searchController,
              decoration: const InputDecoration(
                hintText: 'Search',
                suffixIcon: Icon(Icons.search),
              ),
            ),
          ),
          const SizedBox(height: 10),
          categories.when(
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
                    ref.read(selectedCategoryProvider.notifier).state =
                        data[index];
                    ref.read(subCategoryProvider.notifier).refresh();
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
          ),
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
          )),
          subCategories.when(
            data: (data) {
              if (data.isEmpty) {
                return const SizedBox.shrink();
              }
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        const Text('Shop by subcategory'),
                        const SizedBox(width: 20),
                        Expanded(
                          child: SizedBox(
                            height: 35,
                            child: InputDecorator(
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.zero,
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4.0)),
                                ),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<ProductCategory>(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  borderRadius: BorderRadius.circular(4),
                                  value: ref.watch(selectedSubCategoryProvider),
                                  onChanged: (value) {
                                    ref
                                        .read(selectedSubCategoryProvider
                                            .notifier)
                                        .state = value!;
                                    ref.read(currentLoadingTypeProvider.notifier).state = LoadingType.filteredBySubCategory;
                                    if (value.id != 0) {
                                      ref
                                          .read(productProvider.notifier)
                                          .filterBySubCategory();
                                    }
                                  },
                                  items: data
                                      .map(
                                        (e) =>
                                            DropdownMenuItem<ProductCategory>(
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
                      ],
                    ),
                  ),
                  const SizedBox(height: 5),
                  Align(
                    alignment: Alignment.centerRight,
                    child: SizedBox(
                      height: 30,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return Container(
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(16),
                                    topRight: Radius.circular(16),
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 16,
                                    ),
                                  ],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        ListTile(
                                          title: const Text(
                                            'Choose your brands',
                                            textAlign: TextAlign.center,
                                          ),
                                          contentPadding: EdgeInsets.zero,
                                          trailing: Container(
                                            width: 30,
                                            height: 30,
                                            decoration: const BoxDecoration(
                                                color: Colors.red,
                                                shape: BoxShape.circle),
                                            child: IconButton(
                                              padding: EdgeInsets.zero,
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              icon: const Icon(Icons.close,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                        brands.when(
                                          data: (data) {
                                            return Wrap(
                                              children: data
                                                  .map(
                                                    (e) => Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: ChoiceChip(
                                                        label:
                                                            Text(e.brandName),
                                                        selected: ref
                                                            .watch(
                                                                selectedBrandProvider)
                                                            .contains(e),
                                                        onSelected: (value) {},
                                                      ),
                                                    ),
                                                  )
                                                  .toList(),
                                            );
                                          },
                                          loading: () =>
                                              const CircularProgressIndicator(),
                                          error: (error, stackTrace) => Center(
                                            child: Text(error.toString()),
                                          ),
                                        ),
                                        const SizedBox(height: 16),
                                        const SizedBox(height: 16),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              bottomLeft: Radius.circular(15),
                            ),
                          ),
                        ),
                        label: const Text('Filter'),
                        icon: const Icon(Icons.filter_alt_outlined),
                      ),
                    ),
                  )
                ],
              );
            },
            loading: () => const SizedBox.shrink(),
            error: (error, stackTrace) => const SizedBox.shrink(),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Featured Products',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                products.when(
                  data: (data) => Text('${data.data.length} search results'),
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
