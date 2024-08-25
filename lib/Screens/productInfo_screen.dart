import 'dart:convert'; // Import for JSON encoding/decoding
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sanlak/Components/reusableText.dart';
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
      backgroundColor: Colors.grey[200],
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
                  color: const Color.fromARGB(255, 186, 215, 229),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const Center(
                        child: MyText(
                          'Image not available',
                        ),
                      );
                    },
                  ),
                ),
              ),
              spaceBox(h: 20),
              Row(
                children: [
                  spaceBox(w: MediaQuery.of(context).size.width / 30),
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
                  spaceBox(w: MediaQuery.of(context).size.width / 30),
                  const MyText(
                    'Price: ', fontSize: 18,
                    //  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  MyText(
                    '\$${price.toStringAsFixed(2)}',
                    color: const Color.fromARGB(255, 7, 151, 12),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  const Spacer(),
                ],
              ),
              const Spacer(),
              Row(
                children: [
                  SizedBox(
                    width: 60,
                    child: MaterialButton(
                      height: 50,
                      color: Colors.white,
                      child: const Center(child: Icon(Icons.home)),
                      onPressed: () {
                        Navigator.pushNamed(context, '/home');
                        // Navigator.pushNamed(context, '/cart');
                      },
                    ),
                  ),
                  spaceBox(w: MediaQuery.of(context).size.width / 30),
                  SizedBox(
                    width: 250,
                    child: CupertinoButton(
                      color: Colors.black,
                      child: const MyText(
                        'ADD TO CART',
                        color: Colors.white,
                      ),
                      onPressed: () {
                        _addToCart(
                            context, id, name, imageUrl, description, price);
                        const SnackBar(content: Text('Added to Cart'));
                        // Navigator.pushNamed(context, '/cart');
                      },
                    ),
                  ),
                  // SizedBox(
                  //   width: 80,
                  //   child: MaterialButton(
                  //     height: 50,
                  //     color: Colors.white,
                  //     child: const Center(child: Icon(Icons.category_rounded)),
                  //     onPressed: () {
                  //       Navigator.pushNamed(context, '/cart');
                  //       // Navigator.pushNamed(context, '/cart');
                  //     },
                  //   ),
                  // ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
