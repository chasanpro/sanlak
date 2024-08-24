import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
        height: 300,
        width: 300,
        decoration: BoxDecoration(
            color: Colors.orange, borderRadius: BorderRadius.circular(15)),
      ),
    );
  }
}
