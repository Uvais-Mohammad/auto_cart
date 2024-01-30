import 'package:auto_cart/src/features/home/widgets/app_bar.dart';
import 'package:auto_cart/src/features/home/widgets/category/sub_category_section.dart';
import 'package:auto_cart/src/features/home/widgets/product/all_product_section.dart';
import 'package:auto_cart/src/features/home/widgets/product/category_list.dart';
import 'package:auto_cart/src/features/home/widgets/product/search_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductScreen extends ConsumerStatefulWidget {
  const ProductScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProductScreenState();
}

class _ProductScreenState extends ConsumerState<ProductScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: MyAppBar(
        title: 'Featured Products',
      ),
      body: Column(
        children: [
          SearchField(),
          CategoryList(),
          SubCategorySection(),
          AllProductSection()
        ],
      ),
    );
  }
}
