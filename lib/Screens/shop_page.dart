import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sanlak/Components/Product_card.dart';
import 'package:sanlak/Components/drawer_item.dart';
import 'package:sanlak/Components/reusables.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _selectedPriceOrder = 'Low to High';

  final Map<String, bool> _selectedCategories = {
    'Category A': false,
    'Category B': false,
    'Category C': false,
    'Category D': false,
  };

  void _showFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              title: const Text('Filter Products',
                  style: TextStyle(color: Colors.black)),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Sort by Price',
                      style: TextStyle(color: Colors.black)),
                  ListTile(
                    title: const Text('Low to High',
                        style: TextStyle(color: Colors.black)),
                    leading: Radio<String>(
                      value: 'Low to High',
                      groupValue: _selectedPriceOrder,
                      activeColor: Colors.black,
                      onChanged: (value) {
                        setState(() {
                          _selectedPriceOrder = value!;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('High to Low',
                        style: TextStyle(color: Colors.black)),
                    leading: Radio<String>(
                      value: 'High to Low',
                      groupValue: _selectedPriceOrder,
                      activeColor: Colors.black,
                      onChanged: (value) {
                        setState(() {
                          _selectedPriceOrder = value!;
                        });
                      },
                    ),
                  ),
                  const Divider(color: Colors.black),
                  const Text('Select Categories',
                      style: TextStyle(color: Colors.black)),
                  ..._selectedCategories.keys.map((category) {
                    return CheckboxListTile(
                      checkColor: Colors.white,
                      activeColor: Colors.black,
                      title: Text(category,
                          style: const TextStyle(color: Colors.black)),
                      value: _selectedCategories[category],
                      onChanged: (bool? value) {
                        setState(() {
                          _selectedCategories[category] = value!;
                        });
                      },
                    );
                  }),
                ],
              ),
              actions: [
                CupertinoButton(
                  color: Colors.black,
                  onPressed: () {
                    // Apply the filters (e.g., update the product list)
                    Navigator.of(context).pop();
                  },
                  child: const Text('Apply Filters',
                      style: TextStyle(color: Colors.white)),
                ),
                CupertinoButton(
                  color: Colors.black,
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Close',
                      style: TextStyle(color: Colors.white)),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showFilterDialog(context),
      ),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        elevation: 0,
        title: const Text('MARKET'),
        actions: [
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, '/cart'),
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.shopping_cart),
            ),
          )
        ],
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
              onTap: () => Navigator.pushNamed(context, '/cart'),
            ),
            spaceBox(h: 25),
            DrawerItem(
              title: 'Orders',
              icon: Icons.list_alt_rounded,
              onTap: () => Navigator.pushNamed(context, '/orders'),
            ),
            spaceBox(h: 25),
            const Spacer(),
            DrawerItem(
              title: 'Quit APP',
              icon: Icons.exit_to_app,
              onTap: () => Navigator.pushNamed(context, '/login'),
            ),
            spaceBox(h: 25),
          ],
        ),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * .9,
              child: SingleChildScrollView(
                scrollDirection: Axis
                    .vertical, // You can change this to Axis.horizontal if needed
                child: Wrap(
                  children: [
                    ProductCard(
                      onTap: () => Navigator.pushNamed(context, '/productinfo'),
                    ),
                    ProductCard(
                      onTap: () => Navigator.pushNamed(context, '/productinfo'),
                    ),
                    ProductCard(
                      onTap: () => Navigator.pushNamed(context, '/productinfo'),
                    ),
                    ProductCard(
                      onTap: () => Navigator.pushNamed(context, '/productinfo'),
                    ),
                    ProductCard(
                      onTap: () => Navigator.pushNamed(context, '/productinfo'),
                    ),
                    ProductCard(
                      onTap: () => Navigator.pushNamed(context, '/productinfo'),
                    ),
                    ProductCard(
                      onTap: () => Navigator.pushNamed(context, '/productinfo'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
