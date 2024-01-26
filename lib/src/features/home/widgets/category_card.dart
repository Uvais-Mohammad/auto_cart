import 'package:auto_cart/src/features/home/models/category.dart';
import 'package:auto_cart/src/shared/extensions/string_extensions.dart';
import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({super.key, required this.category});

  final ProductCategory category;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image.network(
              category.image.imageUrl,
              height: 50,
              width: 50,
            ),
            Text(
              category.categoryName,
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ],
        ),
      ),
    );
  }
}
