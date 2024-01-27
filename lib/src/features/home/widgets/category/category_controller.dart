import 'package:auto_cart/src/features/home/logic/category/category_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoryController extends ConsumerWidget {
  const CategoryController({super.key, required this.id});

  final int id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final category = ref.watch(selectedCategoryProvider);
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Container(
        height: 5,
        width: 5,
        decoration: BoxDecoration(
          color: category.id == id ? Colors.red : Colors.transparent,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
