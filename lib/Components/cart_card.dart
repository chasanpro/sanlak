import 'package:flutter/material.dart';
import 'package:sanlak/Components/reusables.dart';

class CartCard extends StatefulWidget {
  final String productName;
  final String productPrice;
  final String? imageUrl;
  final VoidCallback onDelete;
  final VoidCallback? onIncrease; // Add this
  final VoidCallback? onDecrease; // Add this
  final VoidCallback? onTap;
  int quantity;

  CartCard({
    super.key,
    required this.productName,
    required this.productPrice,
    this.imageUrl,
    required this.onDelete,
    this.onIncrease,
    this.onDecrease,
    this.onTap,
    required this.quantity,
  });

  @override
  _CartCardState createState() => _CartCardState();
}

class _CartCardState extends State<CartCard> {
  void _increaseQuantity() {
    if (widget.onIncrease != null) {
      widget.onIncrease!();
    }
  }

  void _decreaseQuantity() {
    if (widget.onDecrease != null) {
      widget.onDecrease!();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        height: 115,
        width: double.infinity, // Use double.infinity for full width
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
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
                  Row(
                    children: [
                      Text(
                        widget.productName,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: widget.onTap,
                        child: IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                          onPressed: widget.onDelete,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      SizedBox(
                        width: 60,
                        child: Text(
                          '\$${widget.productPrice}',
                          style: TextStyle(
                            fontSize: 14,
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                        ),
                      ),
                      Text(
                        'Quantity : ',
                        style: TextStyle(
                          fontSize: 12,
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
                        '${widget.quantity}',
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
                  const SizedBox(height: 10),
                ],
              ),
            ),

            // Delete Icon
          ],
        ),
      ),
    );
  }
}
