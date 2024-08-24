import 'package:flutter/material.dart';

class OrdersScreen extends StatelessWidget {
  final List<Map<String, dynamic>> orders = [
    {
      "order_id": "ORD-256510797",
      "total_amount": 52.97,
      "products": [
        {"name": "Bestseller Novel", "quantity": 2, "price": 19.99},
        {"name": "Adventure Book", "quantity": 1, "price": 12.99}
      ]
    },
    {
      "order_id": "ORD-277203514",
      "total_amount": 52.97,
      "products": [
        {"name": "Bestseller Novel", "quantity": 2, "price": 19.99},
        {"name": "Adventure Book", "quantity": 1, "price": 12.99}
      ]
    },
    {
      "order_id": "ORD-256510797",
      "total_amount": 52.97,
      "products": [
        {"name": "Bestseller Novel", "quantity": 2, "price": 19.99},
        {"name": "Adventure Book", "quantity": 1, "price": 12.99}
      ]
    },
    {
      "order_id": "ORD-277203514",
      "total_amount": 52.97,
      "products": [
        {"name": "Bestseller Novel", "quantity": 2, "price": 19.99},
        {"name": "Adventure Book", "quantity": 1, "price": 12.99}
      ]
    },
    {
      "order_id": "ORD-256510797",
      "total_amount": 52.97,
      "products": [
        {"name": "Bestseller Novel", "quantity": 2, "price": 19.99},
        {"name": "Adventure Book", "quantity": 1, "price": 12.99}
      ]
    },
    {
      "order_id": "ORD-277203514",
      "total_amount": 52.97,
      "products": [
        {"name": "Bestseller Novel", "quantity": 2, "price": 19.99},
        {"name": "Adventure Book", "quantity": 1, "price": 12.99}
      ]
    },
    {
      "order_id": "ORD-256510797",
      "total_amount": 52.97,
      "products": [
        {"name": "Bestseller Novel", "quantity": 2, "price": 19.99},
        {"name": "Adventure Book", "quantity": 1, "price": 12.99}
      ]
    },
    {
      "order_id": "ORD-277203514",
      "total_amount": 52.97,
      "products": [
        {"name": "Bestseller Novel", "quantity": 2, "price": 19.99},
        {"name": "Adventure Book", "quantity": 1, "price": 12.99}
      ]
    }
    // Add other orders here...
  ];

  OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Orders')),
      body: ListView.builder(
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
                      style: const TextStyle(fontWeight: FontWeight.bold)),
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
      ),
    );
  }
}
