import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sanlak/Core/AppProvider.dart';
import 'package:sanlak/Screens/Products/shop_provider.dart';
import 'package:sanlak/Screens/productInfo_screen.dart';
import 'package:sanlak/Screens/login_screen.dart';
import 'package:sanlak/Screens/cart_screen.dart';
import 'package:sanlak/Screens/intro_screen.dart';
import 'package:sanlak/Screens/orders.dart';
import 'package:sanlak/Screens/Products/shop_page.dart';
import 'package:sanlak/Screens/signup_Screen.dart';
import 'package:sanlak/themes/light_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppStateProvider()),
        ChangeNotifierProvider(create: (_) => ProductProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'SanLak',
        theme: lightTheme,
        routes: {
          '/introScreen': (context) => const IntroScreen(),
          '/home': (context) => const HomeScreen(),
          '/cart': (context) => const CartScreen(),
          '/login': (context) => const LoginScreen(),
          '/signup': (context) => const SignupScreen(),
          '/orders': (context) => const OrdersScreen(),
          '/productinfo': (context) => const ProductinfoScreen(),
        },
        home: const IntroScreen());
  }
}
