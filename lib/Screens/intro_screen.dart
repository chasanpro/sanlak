import 'package:flutter/material.dart';
import 'package:sanlak/Components/myButton.dart';
import 'package:sanlak/Components/reusables.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            spaceBox(h: 120),
            Icon(Icons.shopping_bag,
                size: 90, color: Theme.of(context).colorScheme.inversePrimary),
            spaceBox(h: 20),
            const Text(
              'SANLAK INTERVIEW TASK',
              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
            ),
            spaceBox(h: 20),
            const Text(
              'CHAITANYA DAMARASINGU',
              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 13),
            ),
            spaceBox(h: 80),
            MyButton(
                onTap: () => Navigator.pushNamed(context, '/home'),
                child: Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Theme.of(context).colorScheme.primary),
                  child: Icon(Icons.arrow_forward,
                      size: 40,
                      color: Theme.of(context).colorScheme.inversePrimary),
                ))
          ],
        ),
      ),
    );
  }
}
