import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  Future<List<Map<String, dynamic>>> fetchOrders() async {
    final prefs = await SharedPreferences.getInstance();
    String uid = '1521aee7dbe5494899316b2da0d0c598';
    uid = prefs.getString('uid') ?? '';
    final headers = {
      'Accept': 'application/json',
      'Authorization':
          'Bearer ogpJ6ec2nZvO0aNqVmteizayDEECWoSA8KX1fq2HrhIM7falKm7zqa4im4lvFuVG', // Replace with your API key
      'Content-Type': 'application/json',
    };
    String url =
        'https://ap-south-1.aws.data.mongodb-api.com/app/data-gxmmnfs/endpoint/getUserOrders?uid=$uid'; // Replace with your actual endpoint

    try {
      final response = await http.get(Uri.parse(url), headers: headers);
      print(response.body);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List<dynamic> ordersJson = data['orders'] ?? [];
        return ordersJson
            .map((order) => Map<String, dynamic>.from(order))
            .toList();
      } else {
        throw Exception('Failed to load orders');
      }
    } catch (e) {
      print(e);
      throw Exception('Failed to load orders');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Orders')),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: fetchOrders(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No orders available'));
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
