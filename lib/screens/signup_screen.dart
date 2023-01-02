import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  static const screenId = 'Signup screen';

  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  late final TextEditingController _usernameController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Username TextField
          TextField(
            controller: _usernameController,
          ),
          const SizedBox(height: 30),

          // Password TextField
          TextField(
            controller: _passwordController,
          ),
          const SizedBox(height: 30),

          ElevatedButton(
            onPressed: () {},
            child: const Text(
              'Sign up',
              style: TextStyle(fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }
}
