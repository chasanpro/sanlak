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
  List<Product> _filteredProducts = [];

  List<Product> get products => _filteredProducts;

  final headers = {
    'Accept': 'application/json',
    'Authorization': 'Bearer abcd', // Replace with your API key
    'Content-Type': 'application/json',
  };

  Future<void> fetchAndSetProducts() async {
    const url =
        'https://ap-south-1.aws.data.mongodb-api.com/app/data-gxmmnfs/endpoint/getProductDetails';

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final List<dynamic> productData = json.decode(response.body);
        _products = productData.map((item) => Product.fromJson(item)).toList();
        _filteredProducts = List.from(_products);
        notifyListeners();
      } else {
        // Handle the error case
        print('Failed to load products: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching products: $error');
    }
  }

  void applyFilters({
    required String priceOrder,
    required Map<String, bool> categories,
  }) {
    List<Product> filtered = List.from(_products);

    // Filter by categories
    if (categories.isNotEmpty) {
      filtered = filtered
          .where((product) => categories[product.category] == true)
          .toList();
    }

    // Sort by price
    filtered.sort((a, b) {
      if (priceOrder == 'Low to High') {
        return a.price.compareTo(b.price);
      } else {
        return b.price.compareTo(a.price);
      }
    });

    _filteredProducts = filtered;
    notifyListeners();
  }

  void resetFilters() {
    _filteredProducts = List.from(_products);
    notifyListeners();
  }
}
