import 'package:auto_cart/src/features/home/widgets/primary_card.dart';
import 'package:flutter/material.dart';

class PrimarySection extends StatelessWidget {
  const PrimarySection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(
          child: PrimaryCard(
            title: 'Bookings',
            subtitle: 'View\nbookings',
            icon: Icons.book_online_outlined,
          ),
        ),
        Expanded(
          child: PrimaryCard(
            title: 'Offers',
            subtitle: 'Add/view\noffers',
            icon: Icons.local_offer_outlined,
          ),
        ),
      ],
    );
  }
}
