import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// Define the Product model (as before)
class Product {
  final String id;
  final String category;
  final String name;
  final double price;
  final String description;
  final String imageUrl;
  final List<String> relatedProducts;

  Product({
    required this.id,
    required this.category,
    required this.name,
    required this.price,
    required this.description,
    required this.imageUrl,
    required this.relatedProducts,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['_id'],
      category: json['category'],
      name: json['name'],
      price: json['price'].toDouble(),
      description: json['description'],
      imageUrl: json['image_url'],
      relatedProducts: List<String>.from(json['related_products']),
    );
  }
}

// Define the ProductProvider class
class ProductProvider extends ChangeNotifier {
  List<Product> _products = [];

  List<Product> get products => _products;

  Future<void> fetchAndSetProducts() async {
    const url =
        'https://ap-south-1.aws.data.mongodb-api.com/app/data-gxmmnfs/endpoint/getProductDetails';
    final headers = {
      'Accept': 'application/json',
      'Authorization':
          'Bearer ogpJ6ec2nZvO0aNqVmteizayDEECWoSA8KX1fq2HrhIM7falKm7zqa4im4lvFuVG', // Replace with your API key
      'Content-Type': 'application/json',
    };
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final List<dynamic> productData = json.decode(response.body);
        _products = productData.map((item) => Product.fromJson(item)).toList();
        notifyListeners();
      } else {
        // Handle the error case
        print('Failed to load products: ${response.body}');
      }
    } catch (error) {
      print('Error fetching products: $error');
      // Handle the exception
    }
  }
}
