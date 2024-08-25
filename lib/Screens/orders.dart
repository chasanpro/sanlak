import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sanlak/Components/reusableText.dart';
import 'package:sanlak/Components/reusables.dart';
import 'package:sanlak/Core/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  Future<List<Map<String, dynamic>>> fetchOrders() async {
    final prefs = await SharedPreferences.getInstance();
    String uid = prefs.getString('uid') ?? '';

    if (uid.isEmpty) {
      // If the UID is empty, return an empty list immediately
      return [];
    }

    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $apiKey', // Replace with your API key
      'Content-Type': 'application/json',
    };

    String url =
        'https://ap-south-1.aws.data.mongodb-api.com/app/data-gxmmnfs/endpoint/getUserOrders?uid=$uid'; // Replace with your actual endpoint

    try {
      final response = await http.get(Uri.parse(url), headers: headers);
      // print(response.body);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List<dynamic> ordersJson = data['orders'] ?? [];
        return ordersJson
            .map((order) => Map<String, dynamic>.from(order))
            .toList()
            .reversed
            .toList();
      } else {
        return [];
      }
    } catch (e) {
      print('Error fetching orders: $e');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const MyText('Orders'),
        leading: GestureDetector(
          child: const Icon(
            Icons.home,
            color: Colors.black,
          ),
          onTap: () => Navigator.pushNamed(context, '/home'),
        ),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: fetchOrders(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CupertinoButton(
                    color: Colors.black,
                    onPressed: () {
                      Navigator.pushNamed(context, '/login');
                    },
                    child: const MyText(
                      'LOGIN NOW',
                      fontSize: 12,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Text('No orders found, Try Logging in'),
                ],
              ),
            );
          } else {
            final orders = snapshot.data!;

            return ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];
                return Card(
                  margin: const EdgeInsets.all(8),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Order ID: ${order['order_id']}',
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                        Text('Total Amount: \$${order['total_amount']}'),
                        const SizedBox(height: 8),
                        ...order['products'].map<Widget>((product) {
                          return Text(
                            '${product['name']}: ${product['quantity']} x \$${product['price']}',
                          );
                        }).toList(),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
