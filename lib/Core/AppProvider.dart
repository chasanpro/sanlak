import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:sanlak/Core/cart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppStateProvider with ChangeNotifier {
  final headers = {
    'Accept': 'application/json',
    'Authorization':
        'Bearer ogpJ6ec2nZvO0aNqVmteizayDEECWoSA8KX1fq2HrhIM7falKm7zqa4im4lvFuVG', // Replace with your API key
    'Content-Type': 'application/json',
  };
  Future<String> login(String email, String password) async {
    const url =
        'https://ap-south-1.aws.data.mongodb-api.com/app/data-gxmmnfs/endpoint/login';

    final body = jsonEncode({
      'email': email,
      'password': password,
    });

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: body,
      );

      if (response.statusCode == 200) {
        print(response.body);
        final responseData = jsonDecode(response.body);

        // Extract user details
        // final userId = responseData['user_id'];
        final uid = responseData['user']['uid'];

        final email = responseData['user']['email'];
        final confirmed = responseData['user']['confirmed'];
        final createdAt = responseData['user']['createdAt'];
        final address = responseData['user']['address'];
        final cardDetails = responseData['user']['cardDetails'];

        final prefs = await SharedPreferences.getInstance();
        //await prefs.setString('user_id', userId);
        await prefs.setString('uid', uid);
        await prefs.setString('email', email);
        await prefs.setBool('confirmed', confirmed);
        await prefs.setString('createdAt', createdAt);
        await prefs.setString('address', jsonEncode(address));
        await prefs.setString('cardDetails', jsonEncode(cardDetails));

        return responseData['message']; // Return the success message
      } else {
        return 'Failed to login: ${response.statusCode}';
      }
    } catch (error) {
      return 'An error occurred: $error';
    }
  }

  Future<void> addProduct(Product product) async {
    final prefs = await SharedPreferences.getInstance();
    final productsJson = prefs.getString('products') ?? '[]';
    final List<dynamic> productsList = jsonDecode(productsJson);

    productsList.add(product.toJson());

    await prefs.setString('products', jsonEncode(productsList));
    notifyListeners();
  }

  Future<void> deleteProduct(String productId) async {
    final prefs = await SharedPreferences.getInstance();
    final productsJson = prefs.getString('products') ?? '[]';
    final List<dynamic> productsList = jsonDecode(productsJson);

    // Remove all products with the matching productId
    final updatedList =
        productsList.where((p) => p['product_id'] != productId).toList();

    await prefs.setString('products', jsonEncode(updatedList));
    notifyListeners();
  }

  Future<void> updateProduct(Product updatedProduct) async {
    final prefs = await SharedPreferences.getInstance();
    final productsJson = prefs.getString('products') ?? '[]';
    final List<dynamic> productsList = jsonDecode(productsJson);

    // Update the product with the matching productId
    final updatedList = productsList.map((p) {
      if (p['product_id'] == updatedProduct.productId) {
        return updatedProduct.toJson();
      }
      return p;
    }).toList();

    await prefs.setString('products', jsonEncode(updatedList));
    notifyListeners();
  }

  Future<List<Product>> fetchAllProducts() async {
    final prefs = await SharedPreferences.getInstance();
    final productsJson = prefs.getString('products') ?? '[]';
    final List<dynamic> productsList = jsonDecode(productsJson);

    return productsList.map((p) => Product.fromJson(p)).toList();
  }

  Future<void> clearAllData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_id');
    await prefs.remove('uid');
    await prefs.remove('email');
    await prefs.remove('confirmed');
    await prefs.remove('createdAt');
    await prefs.remove('address');
    await prefs.remove('cardDetails');
  }
}

Future<Map<String, dynamic>> fetchUserData() async {
  final prefs = await SharedPreferences.getInstance();

  // Fetch user details from shared preferences
  final userId = prefs.getString('user_id') ?? '';
  final uid = prefs.getString('uid') ?? '';
  final email = prefs.getString('email') ?? '';
  final confirmed = prefs.getBool('confirmed') ?? false;
  final createdAt = prefs.getString('createdAt') ?? '';
  final addressJson = prefs.getString('address') ?? '{}';
  final cardDetailsJson = prefs.getString('cardDetails') ?? '{}';

  // Decode JSON strings
  final address = jsonDecode(addressJson);
  final cardDetails = jsonDecode(cardDetailsJson);

  return {
    'user_id': userId,
    'uid': uid,
    'email': email,
    'confirmed': confirmed,
    'createdAt': createdAt,
    'address': address,
    'cardDetails': cardDetails,
  };
}

class Product {
  final String productId;
  final String name;
  final double price;
  final int quantity;
  final double totalPrice;

  Product({
    required this.productId,
    required this.name,
    required this.price,
    required this.quantity,
    required this.totalPrice,
  });

  Map<String, dynamic> toJson() => {
        'product_id': productId,
        'name': name,
        'price': price,
        'quantity': quantity,
        'total_price': totalPrice,
      };

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        productId: json['product_id'],
        name: json['name'],
        price: json['price'],
        quantity: json['quantity'],
        totalPrice: json['total_price'],
      );
}
