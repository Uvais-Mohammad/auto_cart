import 'package:auto_cart/src/features/home/widgets/app_bar.dart';
import 'package:auto_cart/src/features/home/widgets/category/product_category_section.dart';
import 'package:auto_cart/src/features/home/widgets/my_bottom_bar.dart';
import 'package:auto_cart/src/features/home/widgets/primary_section.dart';
import 'package:auto_cart/src/features/home/widgets/product/featured_section.dart';
import 'package:auto_cart/src/features/home/widgets/product/products_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: MyAppBar(
        title: 'Good Morning',
        isMainAppBar: true,
      ),
      body: Column(
        children: [
          PrimarySection(),
          ProductCategorySection(),
          FeaturedProductSection(),
        ],
      ),
      bottomNavigationBar: MyBottomBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: ProductsButton(),
    );
  }
}
