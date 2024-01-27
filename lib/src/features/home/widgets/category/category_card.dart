import 'package:auto_cart/src/features/home/models/category.dart';
import 'package:auto_cart/src/features/home/widgets/category/category_controller.dart';
import 'package:auto_cart/src/shared/extensions/string_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoryCard extends ConsumerWidget {

  const CategoryCard({
    super.key,
    required this.category,
    this.onTap,
    this.isAllProducts = false,
    this.isCategoryControlled = false,
    this.isAllCategory = false,
  });

  final ProductCategory category;
  final VoidCallback? onTap;
  final bool isAllProducts;
  final bool isCategoryControlled;
  final bool isAllCategory;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Expanded(
          child: Card(
            margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
            child: InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(12),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: isAllCategory
                      ? CrossAxisAlignment.stretch
                      : CrossAxisAlignment.center,
                  children: [
                    if (!isAllProducts)
                      Image.network(
                        category.image!.imageUrl,
                        height: 30,
                        width: 30,
                      ),
                    const SizedBox(height: 5),
                    if (isAllProducts)
                      Column(
                        children: [
                          Text(
                            'All',
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          Text(
                            'Products',
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ],
                      )
                    else
                      Text(
                        category.categoryName,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
        if (isCategoryControlled || isAllProducts)
          CategoryController(
            id: category.id,
          )
      ],
    );
  }
  
}
