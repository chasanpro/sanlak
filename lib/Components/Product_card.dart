import 'package:flutter/material.dart';
import 'package:sanlak/Components/reusables.dart';

class ProductCard extends StatelessWidget {
  final void Function()? onTap;
  final String price, name, imageUrl;
  final double height, width;

  const ProductCard({
    super.key,
    this.onTap,
    required this.price,
    required this.name,
    required this.imageUrl,
    required this.height,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: Column(
              children: [
                spaceBox(h: 10),
                // Display the product image with placeholder and error handling
                Container(
                  height: height * .7,
                  width: width * .9,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, progress) {
                        if (progress == null) {
                          return child;
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return const Center(
                          child: Icon(Icons.error, color: Colors.red),
                        );
                      },
                    ),
                  ),
                ),

                spaceBox(h: 10),
                Row(
                  children: [
                    spaceBox(w: 30),
                    Text(
                      name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
                Row(
                  children: [
                    spaceBox(w: 30),
                    Text(
                      '\$ $price',
                      style: const TextStyle(
                        color: Color.fromARGB(255, 7, 151, 12),
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
                spaceBox(h: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
