import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _streetController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _zipCodeController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _cardHolderFullNameController =
      TextEditingController();
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _validFromController = TextEditingController();
  final TextEditingController _validThruController = TextEditingController();

  final String _paymentMode = 'Credit Card';

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final userData = {
        'email': _emailController.text,
        'password': _passwordController.text,
        'address': {
          'street': _streetController.text,
          'city': _cityController.text,
          'state': _stateController.text,
          'zip_code': _zipCodeController.text,
          'country': _countryController.text,
        },
        'cardDetails': {
          'cardHolderFullName': _cardHolderFullNameController.text,
          'cardNumber': _cardNumberController.text,
          'validFrom': _validFromController.text,
          'validThru': _validThruController.text,
        }
      };

      final response = await http.post(
        Uri.parse(
            'https://ap-south-1.aws.data.mongodb-api.com/app/data-gxmmnfs/endpoint/registerUser'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(userData),
      );

      print(response.body);
      if (response.statusCode == 200) {
        Navigator.pushNamed(context, '/login');
      } // Print the response body for debugging
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'REGISTER ACCOUNT',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Email
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: GoogleFonts.poppins(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                style: GoogleFonts.poppins(),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter email';
                  }
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Password
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: GoogleFonts.poppins(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                obscureText: true,
                style: GoogleFonts.poppins(),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter password';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Address Fields
              TextFormField(
                controller: _streetController,
                decoration: InputDecoration(
                  labelText: 'Street',
                  labelStyle: GoogleFonts.poppins(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                style: GoogleFonts.poppins(),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter street';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _cityController,
                decoration: InputDecoration(
                  labelText: 'City',
                  labelStyle: GoogleFonts.poppins(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                style: GoogleFonts.poppins(),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter city';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _stateController,
                decoration: InputDecoration(
                  labelText: 'State',
                  labelStyle: GoogleFonts.poppins(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                style: GoogleFonts.poppins(),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter state';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _zipCodeController,
                decoration: InputDecoration(
                  labelText: 'Zip Code',
                  labelStyle: GoogleFonts.poppins(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                keyboardType: TextInputType.number,
                style: GoogleFonts.poppins(),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter zip code';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _countryController,
                decoration: InputDecoration(
                  labelText: 'Country',
                  labelStyle: GoogleFonts.poppins(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                style: GoogleFonts.poppins(),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter country';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Card Details Fields
              TextFormField(
                controller: _cardHolderFullNameController,
                decoration: InputDecoration(
                  labelText: 'Card Holder Full Name',
                  labelStyle: GoogleFonts.poppins(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                style: GoogleFonts.poppins(),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter card holder name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _cardNumberController,
                decoration: InputDecoration(
                  labelText: 'Card Number',
                  labelStyle: GoogleFonts.poppins(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                keyboardType: TextInputType.number,
                style: GoogleFonts.poppins(),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter card number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _validFromController,
                decoration: InputDecoration(
                  labelText: 'Valid From (MM/YY)',
                  labelStyle: GoogleFonts.poppins(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                style: GoogleFonts.poppins(),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter valid from date';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _validThruController,
                decoration: InputDecoration(
                  labelText: 'Valid Thru (MM/YY)',
                  labelStyle: GoogleFonts.poppins(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                style: GoogleFonts.poppins(),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter valid thru date';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Signup Button
              ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  //  primary: Colors.blue,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'SIGN UP',
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
