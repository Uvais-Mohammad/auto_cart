import 'package:flutter/material.dart';

class DeliveryAddressSection extends StatelessWidget {
  const DeliveryAddressSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Row(
        children: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.location_pin),
          ),
          const Text('Test Shop, Kalamassery'),
          const Spacer(),
          TextButton(onPressed: () {}, child: const Text('Change'))
        ],
      ),
    );
  }
}