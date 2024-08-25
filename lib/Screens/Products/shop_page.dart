import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:sanlak/Components/Product_card.dart';
import 'package:sanlak/Components/drawer_item.dart';
import 'package:sanlak/Components/reusableText.dart';
import 'package:sanlak/Components/reusables.dart';
import 'package:sanlak/Core/AppProvider.dart';

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
              title: const MyText(
                'Filter Products',
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const MyText(
                    'Sort by Price',
                  ),
                  ListTile(
                    title: const MyText(
                      'Low to High',
                    ),
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
                    title: const MyText(
                      'High to Low',
                    ),
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
                  const MyText(
                    'Select Categories',
                  ),
                  ..._selectedCategories.keys.map((category) {
                    return CheckboxListTile(
                      checkColor: Colors.white,
                      activeColor: Colors.black,
                      title: MyText(
                        category,
                      ),
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
                Center(
                  child: CupertinoButton(
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
                    child: const MyText(
                      'Apply Filters',
                      color: Colors.white,
                    ),
                  ),
                ),
                spaceBox(h: 10),
                Row(
                  children: [
                    SizedBox(
                      width: 140,
                      child: CupertinoButton(
                        // color: Colors.black,
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
                        child: const MyText(
                          'Clear Filters',
                          color: Colors.black,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 140,
                      child: CupertinoButton(
                        //  color: Colors.wh,
                        onPressed: () => Navigator.of(context).pop(),
                        child: const MyText(
                          'Close',
                          color: Colors.black,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
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
    double scrnWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      drawer: Drawer(
        backgroundColor: Colors.grey[200],
        child: Column(
          children: [
            spaceBox(h: 150),
            SizedBox(
                height: 180,
                child: LottieBuilder.asset(
                  'assets/lottie_animations/cartDrawer.json',
                )),
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
                onTap: () async {
                  final productProvider =
                      Provider.of<AppStateProvider>(context, listen: false);
                  await productProvider.clearAllData();
                  Navigator.pushNamed(context, '/');
                }),
            spaceBox(h: 25),
          ],
        ),
      ),
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
        title: const MyText('SAN STORE'),
        actions: [
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, '/cart'),
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(
                Icons.shopping_cart,
                color: Colors.black,
              ),
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
              child: SizedBox(
                width: scrnWidth,
                child: Center(
                  child: Wrap(
                    alignment: WrapAlignment.start,
                    spacing: 10.0,
                    runSpacing: 8.0,
                    children: productProvider.products.map((product) {
                      return ProductCard(
                        height: scrnWidth < 390 ? 300 : 260,
                        width: scrnWidth < 390 ? 300 : 160,
                        onTap: () => Navigator.pushNamed(
                          context,
                          '/productinfo',
                          arguments: {
                            'id': product.id,
                            'name': product.name,
                            'imageUrl': product.imageUrl,
                            'description': product.description,
                            'price': product.price,
                          },
                        ),
                        price: '\$${product.price.toString()}',
                        name: product.name,
                        imageUrl: product.imageUrl,
                      );
                    }).toList(),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
