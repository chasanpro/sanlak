import 'package:flutter/material.dart';
import 'package:sanlak/Components/drawer_item.dart';
import 'package:sanlak/Components/reusables.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        elevation: 0,
        title: const Text('MARKET'),
      ),
      drawer: Drawer(
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: Column(
          children: [
            spaceBox(h: 190),
            Icon(Icons.shopping_bag,
                size: 90, color: Theme.of(context).colorScheme.inversePrimary),
            spaceBox(h: 25),
            DrawerItem(
              title: 'Home',
              icon: Icons.home,
              onTap: () => Navigator.pushNamed(context, '/home'),
            ),
            spaceBox(h: 25),
            DrawerItem(
              title: 'cart',
              icon: Icons.shopping_basket,
              onTap: () => Navigator.pushNamed(context, '/home'),
            ),
            const Spacer(),
            DrawerItem(
              title: 'Quit APP',
              icon: Icons.exit_to_app,
              onTap: () => Navigator.pushNamed(context, '/home'),
            ),
            spaceBox(h: 25),
          ],
        ),
      ),
    );
  }
}
