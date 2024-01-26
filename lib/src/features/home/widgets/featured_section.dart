import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FeaturedProductSection extends ConsumerWidget {
  const FeaturedProductSection({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 14),
              child: Text(
                'Product Categories',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: TextButton(
                onPressed: () {},
                child: const Text(
                  'View All',
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 5),
        // Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: 4),
        //   child: SizedBox(
        //     height: MediaQuery.sizeOf(context).height * 0.3,
        //     child: GridView.builder(
        //       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        //         crossAxisCount: 3,
        //       ),
        //       itemCount: 6,
        //       itemBuilder: (context, index) => const CategoryCard(
        //         icon: Icons.abc,
        //         title: 'title',
        //       ),
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
