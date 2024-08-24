import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sanlak/Components/reusables.dart';

class ProductinfoScreen extends StatelessWidget {
  const ProductinfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              spaceBox(h: 15),
              Container(
                height: 400,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
              ),
              spaceBox(h: 20),
              Row(
                children: [
                  spaceBox(w: 10),
                  Text(
                    'Intel Ultra 200',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Theme.of(context).colorScheme.inversePrimary),
                  ),
                  const Spacer()
                ],
              ),
              spaceBox(h: 20),
              const Text(
                'Flutter is an open-source UI software development toolkit created by Google. '
                'It is used to develop cross platform applications for Android, iOS, Linux, '
                'macOS, Windows, Google Fuchsia, and the web from a single codebase. '
                'The first version of Flutter was known as "Sky" and ran on the Android operating system. '
                'It was unveiled at the 2015 Dart developer summit, with the stated intent of being able '
                'to render consistently at 120 frames per second.',
                style: TextStyle(fontSize: 16.0),
                textAlign: TextAlign.justify,
              ),
              const Row(
                children: [
                  Text(
                    'Price: ',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  Text(
                    '\$200',
                    style: TextStyle(
                        color: Color.fromARGB(
                          255,
                          7,
                          151,
                          12,
                        ),
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  Spacer()
                ],
              ),
              const Spacer(),
              CupertinoButton(
                  color: Colors.blue,
                  child: const Text(
                    'ADD TO CART',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/cart');
                  })
            ],
          ),
        ),
      ),
    );
  }
}
