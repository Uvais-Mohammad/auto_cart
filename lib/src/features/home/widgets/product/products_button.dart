import 'package:flutter/material.dart';

class ProductsButton extends StatelessWidget {
  const ProductsButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90.0,
      width: 90.0,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FittedBox(
          child: FloatingActionButton(
            onPressed: () {},
            backgroundColor: Colors.red,
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}