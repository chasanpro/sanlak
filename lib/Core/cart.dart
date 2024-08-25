import 'dart:convert';

import 'package:sanlak/Core/AppProvider.dart';
import 'package:sanlak/Screens/cart_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> createRequestBody() async {
  final prefs = await SharedPreferences.getInstance();

  // Fetching data from SharedPreferences
  final String uid = prefs.getString('uid') ?? '';
  final String productsJson = prefs.getString('productsList') ?? '[]';
  final List<dynamic> productsList = jsonDecode(productsJson);
  final String addressJson = prefs.getString('address') ?? '{}';
  final Map<String, dynamic> address = jsonDecode(addressJson);
  final String paymentMode = prefs.getString('payment_mode') ?? '';
  final double totalAmount = prefs.getDouble('total_amount') ?? 0.0;
  final String orderDateTime = DateTime.now().toString();
  final String status = prefs.getString('status') ?? '';

  List<dynamic> productsList0 = [];

  final temp = prefs.getString('productsList') ?? '[]';

  productsList0 = jsonDecode(productsJson);
  //  print(_productsList.length);

  final cartItems = productsList0.map((product) {
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

  print('😎😎 $totalCartValue');
  // Creating the request body
  final Map<String, dynamic> requestBody = {
    "uid": uid,
    "products": productsList,
    "address": address,
    "payment_mode": paymentMode,
    "total_amount": totalCartValue,
    "order_date_time": orderDateTime,
    "status": status,
  };

  return requestBody;
}

// Usage example
Future<void> sendRequest() async {
  final requestBody = await createRequestBody();

  // Convert the request body to JSON if needed
  final requestBodyJson = jsonEncode(requestBody);

  // Now you can use requestBodyJson in your HTTP request
  print(requestBodyJson);
}

Future<int> sendOrderRequest() async {
  // Fetch request body from SharedPreferences
  final requestBody = await createRequestBody();

  // Convert request body to JSON
  final requestBodyJson = jsonEncode(requestBody);

  // Define the endpoint
  final url = Uri.parse(
      'https://ap-south-1.aws.data.mongodb-api.com/app/data-gxmmnfs/endpoint/placeOrder');

  final headers = {
    'Accept': 'application/json',
    'Authorization': 'Bearer apiKey', // Replace with your API key
    'Content-Type': 'application/json',
  };

  try {
    // Send the POST request
    final response = await http.post(
      url,
      headers: headers,
      body: requestBodyJson,
    );
    print(response.body);
    // Return the status code based on the response
    if (response.statusCode == 200) {
      return 200; // Request was successful
    } else {
      return 400; // Request failed
    }
  } catch (e) {
    // Handle errors
    print('Error sending request: $e');
    return 400; // Return 400 in case of an error
  }
}
