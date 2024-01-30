import 'package:auto_cart/src/features/home/logic/cart/cart_providers.dart';
import 'package:auto_cart/src/features/home/widgets/cart/cart_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartScreen extends ConsumerStatefulWidget {
  const CartScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CartScreenState();
}

class _CartScreenState extends ConsumerState<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final cartItems = ref.watch(cartProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Cart'),
      ),
      body: Stack(
        children: [
          cartItems.when(
            skipLoadingOnReload: true,
            data: (data) => ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                final item = data[index];
                return CartCard(item: item);
              },
            ),
            loading: () => const SizedBox.shrink(),
            error: (error, stack) => Center(
              child: Text(error.toString()),
            ),
          ),
          if (cartItems.isLoading)
            Container(
              color: Colors.black.withOpacity(0.1),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            )
        ],
      ),
    );
  }
}
