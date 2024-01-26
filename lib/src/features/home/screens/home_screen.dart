import 'package:auto_cart/src/features/home/widgets/app_bar.dart';
import 'package:auto_cart/src/features/home/widgets/primary_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        appBar: MyAppBar(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Row(
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
              )
            ],
          ),
        ));
  }
}
