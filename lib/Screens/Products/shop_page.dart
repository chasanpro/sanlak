import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sanlak/Components/Product_card.dart';

import 'package:sanlak/Screens/Products/shop_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
// @override
// void initState() {
//   super.initState();
//   // Fetch products when the screen is initialized
//   final productProvider = Provider.of<ProductProvider>(context, listen: false);
//   productProvider.fetchAndSetProducts();
// }

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch products when the screen is initialized
    final productProvider =
        Provider.of<ProductProvider>(context, listen: false);
    productProvider.fetchAndSetProducts();
  }

  String _selectedPriceOrder = 'Low to High';
  Map<String, bool> _selectedCategories = {
    'Books': false,
    'Sports': false,
    'Fashion': false,
    'Electronics': false,
    'Home Appliances': false,
  };
  bool _isFilterActive = false; // Track if filters are applied

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
                    setState(() {
                      _selectedPriceOrder = 'Low to High';
                      _selectedCategories = {
                        'Books': false,
                        'Sports': false,
                        'Fashion': false,
                        'Electronics': false,
                        'Home Appliances': false,
                      };
                      _isFilterActive = false; // No filter applied
                    });
                    Provider.of<ProductProvider>(context, listen: false)
                        .resetFilters();
                    Navigator.of(context).pop();
                  },
                  child: const Text('Reset Filters',
                      style: TextStyle(color: Colors.white)),
                ),
                CupertinoButton(
                  color: Colors.black,
                  onPressed: () {
                    Provider.of<ProductProvider>(context, listen: false)
                        .applyFilters(
                      priceOrder: _selectedPriceOrder,
                      categories: _selectedCategories,
                    );
                    setState(() {
                      _isFilterActive = true; // Filter applied
                    });
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
        backgroundColor: _isFilterActive ? Colors.red : Colors.grey,
        child: const Icon(
          Icons.filter_list,
          color: Colors.white,
        ),
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
      body: Center(
        child: Consumer<ProductProvider>(
          builder: (context, productProvider, child) {
            if (productProvider.products.isEmpty) {
              return const CircularProgressIndicator();
            }

            return SingleChildScrollView(
              child: Wrap(
                spacing: 10.0,
                runSpacing: 10.0,
                children: productProvider.products.map((product) {
                  return ProductCard(
                    onTap: () => Navigator.pushNamed(context, '/productinfo'),
                    price: '\$${product.price.toString()}',
                    name: product.name,
                    imageUrl: product.imageUrl,
                  );
                }).toList(),
              ),
            );
          },
        ),
      ),
    );
  }
}
