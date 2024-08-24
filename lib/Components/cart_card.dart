import 'package:flutter/material.dart';
import 'package:sanlak/Components/reusables.dart';

class CartCard extends StatefulWidget {
  final String productName;
  final String productPrice;
  final String? imageUrl;
  final VoidCallback onDelete;

  const CartCard({
    super.key,
    required this.productName,
    required this.productPrice,
    this.imageUrl,
    required this.onDelete,
  });

  @override
  _CartCardState createState() => _CartCardState();
}

class _CartCardState extends State<CartCard> {
  int _quantity = 1;

  void _increaseQuantity() {
    setState(() {
      _quantity++;
    });
  }

  void _decreaseQuantity() {
    if (_quantity > 1) {
      setState(() {
        _quantity--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 100,
        width: 400,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            spaceBox(w: 10),
            // Product Image or Default Icon
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: widget.imageUrl != null && widget.imageUrl!.isNotEmpty
                  ? Image.network(
                      widget.imageUrl!,
                      height: 80,
                      width: 80,
                      fit: BoxFit.cover,
                    )
                  : Container(
                      height: 80,
                      width: 80,
                      color: Colors.grey.shade300,
                      child: Icon(
                        Icons.image_not_supported,
                        size: 40,
                        color: Colors.grey.shade600,
                      ),
                    ),
            ),
            const SizedBox(width: 10),

            // Product Name, Price, and Quantity Controls
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.productName,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      Text(
                        '\$${widget.productPrice}',
                        style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                      Row(
                        children: [
                          spaceBox(w: 50),
                          Text(
                            'Quantity : ',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                          ),
                          // Decrease Quantity Button
                          IconButton(
                            icon: const Icon(Icons.remove),
                            onPressed: _decreaseQuantity,
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                          Text(
                            '$_quantity',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                          ),
                          // Increase Quantity Button
                          IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: _increaseQuantity,
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),

            // Delete Icon
            IconButton(
              icon: Icon(
                Icons.delete,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
              onPressed: widget.onDelete,
            ),
          ],
        ),
      ),
    );
  }
}
