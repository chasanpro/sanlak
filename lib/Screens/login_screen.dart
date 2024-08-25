import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:sanlak/Components/reusableText.dart';
import 'package:sanlak/Components/reusables.dart';
import 'package:sanlak/Core/AppProvider.dart';
// Import the provider class

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String _message = '';

  void _login() async {
    if (_formKey.currentState?.validate() ?? false) {
      final email = _emailController.text;
      final password = _passwordController.text;

      final provider = Provider.of<AppStateProvider>(context, listen: false);
      final message = await provider.login(email, password);
      // print(message);
      if (message == 'Login successful.') {
        Navigator.pushNamed(context, '/home');
      }
      setState(() {
        _message = message;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const MyText('LOGIN')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Container(
            height: 490,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color.fromARGB(255, 236, 234, 234)),
            child: Column(
              children: [
                SizedBox(
                    height: 180,
                    child: LottieBuilder.asset(
                      'assets/lottie_animations/user.json',
                    )),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    fillColor: theme.colorScheme.secondary,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an email';
                    } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                        .hasMatch(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    fillColor: theme.colorScheme.secondary,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a password';
                    } else if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _login,
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const MyText(
                    'LOGIN',
                    fontSize: 12,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                Text(_message,
                    style: TextStyle(color: theme.colorScheme.onSurface)),
                CupertinoButton(
                    child: const MyText(
                      'Create an Account',
                      fontSize: 14,
                    ),
                    onPressed: () => Navigator.pushNamed(context, '/signup')),
                spaceBox(h: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
