import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppStateProvider with ChangeNotifier {
  Future<String> login(String email, String password) async {
    const url =
        'https://ap-south-1.aws.data.mongodb-api.com/app/data-gxmmnfs/endpoint/login';
    final headers = {
      'Accept': 'application/json',
      'Authorization':
          'Bearer ogpJ6ec2nZvO0aNqVmteizayDEECWoSA8KX1fq2HrhIM7falKm7zqa4im4lvFuVG', // Replace with your API key
      'Content-Type': 'application/json',
    };
    final body = jsonEncode({
      'email': email,
      'password': password,
    });

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: body,
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final userId = responseData['user_id'];

        // Save user_id in shared preferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('user_id', userId);

        return responseData['message']; // Return the success message
      } else {
        return 'Failed to login: ${response.statusCode}';
      }
    } catch (error) {
      return 'An error occurred: $error';
    }
  }
}
