import 'package:flutter/material.dart';

class PriceAndOfferSection extends StatelessWidget {
  const PriceAndOfferSection(
      {super.key, required this.offerPrice, required this.price});

  final int offerPrice;
  final int price;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Exclusive Launch Offer',
            style: theme.textTheme.titleSmall,
          ),
          Row(
            children: [
              Text(
                '₹ ${offerPrice.toString()}',
                style: theme.textTheme.titleLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                price.toString(),
                style: theme.textTheme.titleLarge!.copyWith(
                  decoration: TextDecoration.lineThrough,
                  fontSize: 15,
                  decorationColor: Colors.grey,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(width: 8),
              if (offerPercentage(price, offerPrice) != 0)
                Text(
                  '${offerPercentage(price, offerPrice)}% OFF',
                  style: theme.textTheme.titleLarge!.copyWith(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
            ],
          ),
          Row(
            children: [
              const Icon(
                Icons.local_offer_outlined,
                size: 16,
              ),
              Text.rich(
                TextSpan(
                  text: 'Get assured ',
                  style: theme.textTheme.bodyLarge!.copyWith(
                    fontSize: 14,
                  ),
                  children: [
                    TextSpan(
                      text: '10% cashback ',
                      style: theme.textTheme.bodyLarge!.copyWith(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    TextSpan(
                      text: 'on every order',
                      style: theme.textTheme.bodyLarge!.copyWith(
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  int offerPercentage(int price, int offerPrice) {
    return ((price - offerPrice) / price * 100).toInt();
  }
}
