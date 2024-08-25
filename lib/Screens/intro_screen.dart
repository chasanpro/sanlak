import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sanlak/Components/myButton.dart';
import 'package:sanlak/Components/reusables.dart';

import 'package:shared_preferences/shared_preferences.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  Future<bool> checkLogin() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String uid = prefs.getString('uid') ?? '';
      return uid.isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  void _handleButtonPress(BuildContext context) async {
    bool isLoggedIn = await checkLogin();
    if (isLoggedIn) {
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            spaceBox(h: 120),
            SizedBox(
                height: 180,
                child: LottieBuilder.asset(
                  'assets/lottie_animations/cart1.json',
                )),
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
              onTap: () => _handleButtonPress(context),
              child: Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Theme.of(context).colorScheme.primary,
                ),
                child: const Icon(
                  Icons.arrow_forward,
                  size: 40,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
