import 'package:flutter/material.dart';
import 'package:sanlak/Components/cart_card.dart';
import 'package:sanlak/Components/reusables.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CART'),
      ),
      body: Center(
        child: Column(
          children: [
            spaceBox(h: 25),
            const Text('YOUR CART IS MISSING YOU'),
            spaceBox(h: 25),
            SizedBox(
              height: 700,
              child: ListView(
                children: [
                  CartCard(
                    productName: 'Intel Core Ultra ',
                    productPrice: '300',
                    imageUrl: '',
                    onDelete: () {},
                  ),
                  CartCard(
                    productName: 'Intel Core Ultra ',
                    productPrice: '300',
                    imageUrl: '',
                    onDelete: () {},
                  ),
                  CartCard(
                    productName: 'Intel Core Ultra ',
                    productPrice: '300',
                    imageUrl: '',
                    onDelete: () {},
                  ),
                  CartCard(
                    productName: 'Intel Core Ultra ',
                    productPrice: '300',
                    imageUrl: '',
                    onDelete: () {},
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
