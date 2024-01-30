import 'package:auto_cart/src/features/home/logic/brand/brand_providers.dart';
import 'package:auto_cart/src/features/home/logic/product/product_provider.dart';
import 'package:auto_cart/src/features/home/models/brand.dart';
import 'package:auto_cart/src/shared/enums/load_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FilterBottomWidget extends ConsumerWidget {
  const FilterBottomWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<List<Brand>> brands = ref.watch(brandProvider);

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
                                crossAxisAlignment: CrossAxisAlignment.center,
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
                                      return Column(
                                        children: data
                                            .map(
                                              (e) => Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8),
                                                child: Row(
                                                  children: [
                                                    Consumer(builder:
                                                        (context, ref, child) {
                                                      return Radio<Brand>(
                                                        value: e,
                                                        groupValue: ref.watch(
                                                            selectedBrandProvider),
                                                        onChanged: (value) {
                                                          ref
                                                              .read(
                                                                  selectedBrandProvider
                                                                      .notifier)
                                                              .state = value!;
                                                          ref
                                                                  .read(currentLoadingTypeProvider
                                                                      .notifier)
                                                                  .state =
                                                              LoadingType
                                                                  .filteredByBrand;
                                                          ref
                                                              .read(
                                                                  productProvider
                                                                      .notifier)
                                                              .filterByBrand();
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                      );
                                                    }),
                                                    Text(e.brandName),
                                                  ],
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
  }
}