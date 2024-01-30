import 'package:auto_cart/src/features/home/logic/cart/cart_providers.dart';
import 'package:auto_cart/src/features/home/logic/product/product_provider.dart';
import 'package:auto_cart/src/features/home/screens/payment_screen.dart';
import 'package:auto_cart/src/features/home/widgets/cart/cart_icon.dart';
import 'package:auto_cart/src/features/home/widgets/product/available_coupons.dart';
import 'package:auto_cart/src/features/home/widgets/product/delivery_section.dart';
import 'package:auto_cart/src/features/home/widgets/product/image_carousel.dart';
import 'package:auto_cart/src/features/home/widgets/product/price_and_offer_section.dart';
import 'package:auto_cart/src/features/home/widgets/product/product_detail_widget.dart';
import 'package:auto_cart/src/shared/extensions/navigation_extensions.dart';
import 'package:auto_cart/src/shared/extensions/string_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductDetailsScreen extends ConsumerStatefulWidget {
  const ProductDetailsScreen({super.key, required this.productId});
  final int productId;
  @override
  ConsumerState<ProductDetailsScreen> createState() =>
      _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends ConsumerState<ProductDetailsScreen> {
  final ValueNotifier<int> _current = ValueNotifier<int>(0);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _current.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final productDetail = ref.watch(productDetailProvider(widget.productId));
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              ' Deliver to :',
              style: TextStyle(fontSize: 12),
              textAlign: TextAlign.center,
            ),
            Row(
              children: [
                const Icon(
                  Icons.location_on_outlined,
                  size: 16,
                  color: Colors.red,
                ),
                const SizedBox(width: 4),
                DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: 'My Shop',
                    isDense: true,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    iconSize: 24,
                    elevation: 16,
                    style: const TextStyle(color: Colors.black),
                    underline: Container(
                      height: 2,
                      color: Colors.black,
                    ),
                    onChanged: (String? newValue) {},
                    items: <String>['My Shop', 'Office', 'Other']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: const TextStyle(color: Colors.black),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_active_outlined),
          ),
          const CartIcon(),
        ],
      ),
      body: productDetail.when(
        data: (product) => SingleChildScrollView(
          child: Column(
            children: [
              ImageCarousel(
                current: _current,
                images: product.images.map((e) => e.imageUrl).toList(),
              ),
              ProductDetailWidget(
                productName: product.productName,
                productDescription: product.description,
              ),
              PriceAndOfferSection(
                offerPrice: product.offerPrice,
                price: product.price,
              ),
              const DeliveryAddressSection(),
              const AvailableCoupons(),
            ],
          ),
        ),
        error: (error, stackTrace) => Center(child: Text(error.toString())),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(
                  left: 16,
                  right: 8,
                  top: 8,
                ),
                child: OutlinedButton(
                  onPressed: () {
                    ref
                        .read(cartProvider.notifier)
                        .addToCart(productId: widget.productId, quantity: 1);
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.black,
                    side: const BorderSide(color: Colors.black),
                  ),
                  child: const Text('Add to Cart'),
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(
                  left: 8,
                  right: 16,
                  top: 8,
                ),
                child: FilledButton(
                  onPressed: () {
                    context.push(const PaymentScreen());
                  },
                  child: const Text('Buy Now'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
