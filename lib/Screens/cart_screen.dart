import 'dart:convert'; // Import for JSON encoding/decoding
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sanlak/Core/AppProvider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sanlak/Components/cart_card.dart';
import 'package:sanlak/Components/reusables.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<dynamic> _productsList = [];

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    final prefs = await SharedPreferences.getInstance();
    final productsJson = prefs.getString('productsList') ?? '[]';
    setState(() {
      _productsList = jsonDecode(productsJson);
      print(_productsList.length);
    });
  }

  Future<void> _updateProductList(List<dynamic> updatedProducts) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('productsList', jsonEncode(updatedProducts));
    setState(() {
      _productsList = updatedProducts;
    });
  }

  void _showDeleteConfirmationDialog(int index) {
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
                  'Delete this item from cart?',
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
                            color:
                                Theme.of(context).colorScheme.inversePrimary),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop(); // Close the dialog
                        _deleteProduct(index);
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

  void _deleteProduct(int index) {
    final updatedProducts = List.from(_productsList)..removeAt(index);
    _updateProductList(updatedProducts);
  }

  void _increaseQuantity(int index) {
    final updatedProducts = List.from(_productsList);
    final product = updatedProducts[index];
    product['quantity'] = product['quantity'] + 1;
    product['total_price'] = product['price'] * product['quantity'];
    _updateProductList(updatedProducts);
  }

  void _decreaseQuantity(int index) {
    final updatedProducts = List.from(_productsList);
    final product = updatedProducts[index];
    if (product['quantity'] > 1) {
      product['quantity'] = product['quantity'] - 1;
      product['total_price'] = product['price'] * product['quantity'];
      _updateProductList(updatedProducts);
    }
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              spaceBox(h: 25),
              const Text('YOUR CART IS MISSING YOU'),
              spaceBox(h: 25),
              Column(
                children: _productsList.map((product) {
                  int index = _productsList.indexOf(product);
                  return CartCard(
                    onTap: () => _showDeleteConfirmationDialog(index),
                    productName: product['name'] ?? 'No Name',
                    productPrice:
                        product['price']?.toStringAsFixed(2) ?? '0.00',
                    imageUrl: product['imageUrl'] ?? '',
                    quantity: product['quantity'] ?? 1,
                    onIncrease: () => _increaseQuantity(index),
                    onDecrease: () => _decreaseQuantity(index),
                    onDelete: () => _showDeleteConfirmationDialog(index),
                  );
                }).toList(),
              ),
              spaceBox(h: 25),
              CupertinoButton(
                color: Colors.blue,
                child: const Text(
                  'Proceed to Buy',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  final cartItems = _productsList.map((product) {
                    return Product(
                      productId: product['productId'] ?? '',
                      name: product['name'] ?? '',
                      price: product['price']?.toDouble() ?? 0.0,
                      quantity: product['quantity'] ?? 1,
                      totalPrice: product['total_price']?.toDouble() ?? 0.0,
                    );
                  }).toList();

                  // Calculate the total value
                  final totalCartValue = calculateTotalCartValue(cartItems);

                  // Print the total value
                  print(
                      'Total Cart Value: \$${totalCartValue.toStringAsFixed(2)}');
                  _showCustomBottomSheet(
                      context, totalCartValue.toStringAsFixed(2));
                  // Handle proceed to buy action
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

double calculateTotalCartValue(List<Product> cartItems) {
  return cartItems.fold(0.0, (sum, item) => sum + (item.price * item.quantity));
}

void _showCustomBottomSheet(BuildContext context, String total) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent, // Make the background transparent
    builder: (context) {
      return Container(
        height: 260, width: double.infinity,
        margin:
            const EdgeInsets.all(15.0), // Add margin to float above the bottom
        decoration: BoxDecoration(
          color: Colors.white, // Set your desired color
          borderRadius: BorderRadius.circular(15), // Border radius
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                '\$ $total',
                style: const TextStyle(
                  fontSize: 60,
                  fontWeight: FontWeight.bold,
                ),
              ),
              spaceBox(h: 15),
              CupertinoButton(
                onPressed: () {},
                color: Colors.black,
                child: const Text(
                  'TAP TO PAY',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              spaceBox(h: 15),
              CupertinoButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'CANCEL',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
