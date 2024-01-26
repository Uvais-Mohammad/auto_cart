import 'package:flutter/material.dart';

class MyBottomBar extends StatelessWidget {
  const MyBottomBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {},
            icon: const Column(
              children: [
                Icon(Icons.home_outlined),
                Text('Home'),
              ],
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Column(
              children: [
                Icon(Icons.search_outlined),
                Text('Search'),
              ],
            ),
          ),
          const IconButton(
            onPressed: null,
            icon: Column(
              children: [
                Icon(Icons.search_outlined, color: Colors.transparent),
                Text('Product'),
              ],
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Column(
              children: [
                Icon(Icons.shopping_cart_outlined),
                Text(' Cart '),
              ],
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Column(
              children: [
                Icon(Icons.person_outline),
                Text('Profile'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}