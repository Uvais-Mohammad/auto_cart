import 'package:auto_cart/src/features/home/widgets/category_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductCategorySection extends ConsumerWidget {
  const ProductCategorySection({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 14),
          child: Text(
            'Product Categories',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        const SizedBox(height: 5),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 110,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) =>
                        const CategoryCard(icon: Icons.abc, title: 'title'),
                  ),
                ),
              ),
              //view all button
              SizedBox(
                height: 110,
                child: Card(
                  margin: const EdgeInsets.fromLTRB(10, 8, 6, 8),
                  child: InkWell(
                    onTap: () {},
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                      child: Row(
                        children: [
                          Text(
                            'View All',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Icon(
                            Icons.chevron_right_outlined,
                            size: 18,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
