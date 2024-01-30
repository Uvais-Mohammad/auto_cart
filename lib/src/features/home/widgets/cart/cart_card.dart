import 'package:auto_cart/src/features/home/logic/cart/cart_providers.dart';
import 'package:auto_cart/src/features/home/models/cart_item.dart';
import 'package:auto_cart/src/shared/extensions/string_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartCard extends ConsumerWidget {
  const CartCard({super.key, required this.item});
  final CartItem item;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: Column(
        children: [
          Stack(
            alignment: Alignment.topRight,
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8),
                      bottomLeft: Radius.circular(8),
                    ),
                    child: Image.network(
                      item.images.imageUrl,
                      height: 120,
                      width: 120,
                      errorBuilder: (context, error, stackTrace) =>
                          const FlutterLogo(
                        size: 120,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    flex: 7,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.productName,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          item.description,
                          style: const TextStyle(
                            color: Colors.grey,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Row(
                          children: [
                            Text(
                              '₹ ${item.offerPrice.toString()}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '₹ ${item.price.toString()}',
                              style: const TextStyle(
                                decoration: TextDecoration.lineThrough,
                                decorationColor: Colors.grey,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(width: 8),
                          ],
                        )
                      ],
                    ),
                  ),
                  const Spacer()
                ],
              ),
              Positioned(
                top: 10,
                right: 10,
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: const BoxDecoration(
                      color: Colors.red, shape: BoxShape.circle),
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      ref
                          .read(cartProvider.notifier)
                          .removeFromCart(id: item.id);
                    },
                    icon: const Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 15,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Row(
              children: [
                const Text('Qty: '),
                const SizedBox(width: 10),
                Expanded(
                  flex: 3,
                  child: SizedBox(
                    height: 35,
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.zero,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4.0)),
                        ),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<int>(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          borderRadius: BorderRadius.circular(4),
                          onChanged: (value) {
                            ref.read(cartProvider.notifier).addToCart(
                                productId: item.productId, quantity: value!);
                          },
                          value: item.qty,
                          items: List.generate(
                            100,
                            (index) => DropdownMenuItem<int>(
                              value: index + 1,
                              child: Text(
                                (index + 1).toString(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                FilledButton(
                  onPressed: () {},
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(12),
                      ),
                    ),
                  ),
                  child: const Text('Move to Wishlist'),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
