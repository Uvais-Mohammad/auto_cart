import 'package:auto_cart/src/features/home/logic/cart/cart_providers.dart';
import 'package:auto_cart/src/features/home/screens/cart_screen.dart';
import 'package:auto_cart/src/shared/extensions/navigation_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartIcon extends ConsumerWidget {
  const CartIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartItems = ref.watch(cartProvider);
    return Badge(
      alignment: Alignment.topLeft,
      padding: cartItems.maybeWhen(
        data: (data) => null,
        orElse: () => EdgeInsets.zero,
      ),
      label: cartItems.when(
        data: (data) => Text(
          data.length.toString(),
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        loading: () => const SizedBox.shrink(),
        error: (error, stack) => const SizedBox.shrink(),
      ),
      child: IconButton(
        onPressed: () {
          context.push(const CartScreen());
        },
        icon: const Icon(Icons.shopping_cart_outlined),
      ),
    );
  }
}
