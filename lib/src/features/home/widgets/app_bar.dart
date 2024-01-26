import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const MyAppBar({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppBar(
      title: const Text('Good Morning'),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.notifications_active_outlined),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.shopping_cart_outlined),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}
