import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sanlak/Components/cart_card.dart';
import 'package:sanlak/Components/reusables.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  void _showBottomDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          height: 300,
          margin: const EdgeInsets.only(bottom: 20, left: 10, right: 10),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'This is a bottom dialog',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                  'This dialog is not stuck to the bottom of the screen.'),
              const SizedBox(height: 20),
              CupertinoButton(
                color: Colors.black,
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Proceed to Pay',
                    style: TextStyle(color: Colors.white)),
              ),
              const SizedBox(height: 20),
              CupertinoButton(
                color: Colors.black,
                onPressed: () => Navigator.of(context).pop(),
                child:
                    const Text('Close', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CART'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.pushNamed(context, '/home');
          },
        ),
      ),
      body: Center(
        child: Column(
          children: [
            spaceBox(h: 25),
            const Text('YOUR CART IS MISSING YOU'),
            spaceBox(h: 25),
            SizedBox(
              height: MediaQuery.of(context).size.height * .7,
              child: ListView(
                children: [
                  CartCard(
                    productName: 'Intel Core Ultra ',
                    productPrice: '300',
                    imageUrl: '',
                    onDelete: () =>
                        _showDeleteConfirmationDialog(context, "product_id"),
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
            ),
            const Spacer(),
            CupertinoButton(
                color: Colors.blue,
                child: const Text(
                  'Proceed to Buy',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  _showBottomDialog(context);
                  //Navigator.pushNamed(context, '/cart');
                }),
            spaceBox(h: 10)
          ],
        ),
      ),
    );
  }
}

void _showDeleteConfirmationDialog(BuildContext context, String message) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          padding: const EdgeInsets.all(16.0),
          height: 130,
          width: 250,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Delte this item from cart?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the dialog
                    },
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.inversePrimary),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    onPressed: () {
                      // Handle delete action
                      Navigator.of(context).pop(); // Close the dialog
                    },
                    child: const Text('Delete'),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}
