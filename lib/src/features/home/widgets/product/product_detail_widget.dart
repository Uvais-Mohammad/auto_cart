import 'package:flutter/material.dart';

class ProductDetailWidget extends StatelessWidget {
  const ProductDetailWidget(
      {super.key, required this.productName, required this.productDescription});
  final String productName;
  final String productDescription;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    productName,
                    maxLines: 2,
                    style: theme.textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 5),
              const Text(
                '⭐️⭐️⭐️⭐️⭐️',
                maxLines: 2,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            productDescription,
            style: theme.textTheme.bodyLarge!.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
        )
      ],
    );
  }
}
