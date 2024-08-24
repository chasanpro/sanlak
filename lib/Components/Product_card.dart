import 'package:flutter/material.dart';
import 'package:sanlak/Components/reusables.dart';

class ProductCard extends StatelessWidget {
  final void Function()? onTap;
  const ProductCard({
    super.key,
    @required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Container(
          height: 260,
          width: 170,
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(15)),
          child: Center(
            child: Column(children: [
              spaceBox(h: 10),
              Container(
                height: 190,
                width: 160,
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    borderRadius: BorderRadius.circular(15)),
              ),
              spaceBox(h: 10),
              Row(
                children: [
                  spaceBox(w: 30),
                  Text(
                    'Intel Ultra 200',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.inversePrimary),
                  ),
                  const Spacer()
                ],
              ),
              Row(
                children: [
                  spaceBox(w: 30),
                  const Text(
                    '\$200',
                    style: TextStyle(
                        color: Color.fromARGB(255, 7, 151, 12),
                        fontWeight: FontWeight.w800),
                  ),
                  const Spacer()
                ],
              ),
              spaceBox(h: 10),
            ]),
          ),
        ),
      ),
    );
  }
}
