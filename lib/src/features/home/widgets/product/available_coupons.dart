import 'package:flutter/material.dart';

class AvailableCoupons extends StatelessWidget {
  const AvailableCoupons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 30, left: 16, right: 16),
      padding: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Available coupons for you'),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.chevron_right_outlined),
          ),
        ],
      ),
    );
  }
}