import 'package:auto_cart/src/features/home/logic/product/product_provider.dart';
import 'package:auto_cart/src/shared/enums/load_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchField extends ConsumerWidget {
  const SearchField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: 40,
      margin: const EdgeInsets.only(bottom: 5),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextField(
        decoration: const InputDecoration(
          hintText: 'Search',
          suffixIcon: Icon(Icons.search),
        ),
        onChanged: (value) {
          ref.read(searchQueryProvider.notifier).state = value;
        },
        onSubmitted: (value) {
          ref.read(currentLoadingTypeProvider.notifier).state =
              LoadingType.filteredBySearch;
          ref.read(productProvider.notifier).filterBySearch();
        },
      ),
    );
  }
}
