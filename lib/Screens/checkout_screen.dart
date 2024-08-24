import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserAddressScreen extends StatefulWidget {
  const UserAddressScreen({super.key});

  @override
  _UserAddressScreenState createState() => _UserAddressScreenState();
}

class _UserAddressScreenState extends State<UserAddressScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _streetController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _zipCodeController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _totalAmountController = TextEditingController();
  final TextEditingController _orderDateTimeController =
      TextEditingController();

  String _paymentMode = 'Credit Card';
  // String _status = 'Pending';

  Future<void> _saveOrderDetails() async {
    if (_formKey.currentState!.validate()) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('address_street', _streetController.text);
      await prefs.setString('address_city', _cityController.text);
      await prefs.setString('address_state', _stateController.text);
      await prefs.setString('address_zip_code', _zipCodeController.text);
      await prefs.setString('address_country', _countryController.text);
      await prefs.setString('payment_mode', _paymentMode);
      await prefs.setDouble(
          'total_amount', double.parse(_totalAmountController.text));
      await prefs.setString('order_date_time', _orderDateTimeController.text);
      // await prefs.setString('status', _status);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Order details saved successfully!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Address Fields
              TextFormField(
                controller: _streetController,
                decoration: const InputDecoration(labelText: 'Street'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter street';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _cityController,
                decoration: const InputDecoration(labelText: 'City'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter city';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _stateController,
                decoration: const InputDecoration(labelText: 'State'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter state';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _zipCodeController,
                decoration: const InputDecoration(labelText: 'Zip Code'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter zip code';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _countryController,
                decoration: const InputDecoration(labelText: 'Country'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter country';
                  }
                  return null;
                },
              ),

              // Payment Mode
              DropdownButtonFormField<String>(
                value: _paymentMode,
                decoration: const InputDecoration(labelText: 'Payment Mode'),
                items:
                    ['Credit Card', 'Debit Card', 'PayPal', 'Cash on Delivery']
                        .map((mode) => DropdownMenuItem(
                              value: mode,
                              child: Text(mode),
                            ))
                        .toList(),
                onChanged: (value) {
                  setState(() {
                    _paymentMode = value!;
                  });
                },
              ),

              // Total Amount
              TextFormField(
                controller: _totalAmountController,
                decoration: const InputDecoration(labelText: 'Total Amount'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter total amount';
                  } else if (double.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),

              // Order Date Time
              TextFormField(
                controller: _orderDateTimeController,
                decoration: const InputDecoration(labelText: 'Order Date Time'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter order date and time';
                  }
                  return null;
                },
              ),

              // Status
              // DropdownButtonFormField<String>(
              //   value: _status,
              //   decoration: const InputDecoration(labelText: 'Status'),
              //   items: ['Pending', 'Processing', 'Shipped', 'Delivered']
              //       .map((status) => DropdownMenuItem(
              //             value: status,
              //             child: Text(status),
              //           ))
              //       .toList(),
              //   onChanged: (value) {
              //     setState(() {
              //       _status = value!;
              //     });
              //   },
              // ),

              // Save Button
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: _saveOrderDetails,
                  child: const Text('Save Order Details'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
