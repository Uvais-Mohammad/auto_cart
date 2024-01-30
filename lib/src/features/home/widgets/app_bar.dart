import 'package:auto_cart/src/features/home/widgets/cart/cart_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const MyAppBar({super.key, required this.title, this.isMainAppBar = false});

  final String title;
  final bool isMainAppBar ;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppBar(
      title: Text(title),
      actions: [
        if (isMainAppBar)
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_active_outlined),
          )
        else
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.favorite_border),
          ),
        const CartIcon(),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}
