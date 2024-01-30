import 'dart:async';

import 'package:auto_cart/src/features/home/models/cart_item.dart';
import 'package:auto_cart/src/features/home/repository/home_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final cartProvider =
    AsyncNotifierProvider<CartNotifier, List<CartItem>>(CartNotifier.new);

class CartNotifier extends AsyncNotifier<List<CartItem>> {
  @override
  FutureOr<List<CartItem>> build() async {
    return ref.read(homeRepositoryProvider).getCartItems(1329);
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () async {
        return ref.read(homeRepositoryProvider).getCartItems(1329);
      },
    );
  }

  Future<void> addToCart(
      {required int productId, required int quantity}) async {
    state = const AsyncLoading<List<CartItem>>();
    final response = await ref
        .read(homeRepositoryProvider)
        .addToCart(shopId: 1329, productId: productId, quantity: quantity);
    if (response) {
      state = await AsyncValue.guard(
        () async {
          return ref.read(homeRepositoryProvider).getCartItems(1329);
        },
      );
    }
  }

  Future<void> removeFromCart({required int id}) async {
    final oldState = state;
    state = const AsyncLoading<List<CartItem>>().copyWithPrevious(oldState);
    final response =
        await ref.read(homeRepositoryProvider).removeFromCart(id: id);
    if (response) {
      state = await AsyncValue.guard(
        () async {
          return ref.read(homeRepositoryProvider).getCartItems(1329);
        },
      );
    }
  }
}
