import 'dart:convert'; // Import for JSON encoding/decoding
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sanlak/Components/reusables.dart';

class ProductinfoScreen extends StatelessWidget {
  const ProductinfoScreen({super.key});

  Future<void> _addToCart(
    BuildContext context,
    String id,
    String name,
    String imageUrl,
    String description,
    double price,
  ) async {
    final prefs = await SharedPreferences.getInstance();

    // Get the existing product list
    final productsJson = prefs.getString('productsList');
    List<dynamic> productsList =
        productsJson != null ? jsonDecode(productsJson) : [];

    // Add the new product to the list
    final newProduct = {
      'product_id': id,
      'name': name,
      'price': price,
      'quantity': 1, // Set initial quantity to 1
      'total_price': price, // Set total price as the product price initially
    };

    productsList.add(newProduct);
    print(newProduct);

    // Save the updated product list back to SharedPreferences
    await prefs.setString('productsList', jsonEncode(productsList));
  }

  @override
  Widget build(BuildContext context) {
    // Extract arguments from the route
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    // Provide default values if arguments are null
    final String name = args?['name'] ?? 'No Name';
    final String imageUrl = args?['imageUrl'] ?? '';
    final String description =
        args?['description'] ?? 'No Description Available';
    final double price = args?['price']?.toDouble() ?? 0.0;
    final String id = args?['id'] ?? 'No ID';

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              spaceBox(h: 15),
              Container(
                height: 400,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const Center(
                        child: Text(
                          'Image not available',
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                      );
                    },
                  ),
                ),
              ),
              spaceBox(h: 20),
              Row(
                children: [
                  spaceBox(w: 10),
                  Text(
                    name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                  ),
                  const Spacer(),
                ],
              ),
              spaceBox(h: 20),
              Text(
                description,
                style: const TextStyle(fontSize: 16.0),
                textAlign: TextAlign.justify,
              ),
              Row(
                children: [
                  const Text(
                    'Price: ',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  Text(
                    '\$${price.toStringAsFixed(2)}',
                    style: const TextStyle(
                      color: Color.fromARGB(255, 7, 151, 12),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                ],
              ),
              const Spacer(),
              CupertinoButton(
                color: Colors.blue,
                child: const Text(
                  'ADD TO CART',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  _addToCart(context, id, name, imageUrl, description, price);
                  const SnackBar(content: Text('Added to Cart'));
                  // Navigator.pushNamed(context, '/cart');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
