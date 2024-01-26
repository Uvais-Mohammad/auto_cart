import 'package:auto_cart/src/features/home/screens/home_screen.dart';
import 'package:auto_cart/src/shared/extensions/navigation_extensions.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 2), () {
      context.pushReplacement(const HomeScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              '🔧',
              style: TextStyle(fontSize: 100),
            ),
          ),
          Text(
            'Auto Cart',
            style: TextStyle(fontSize: 20),
          ),
        ],
      ),
    );
  }
}
