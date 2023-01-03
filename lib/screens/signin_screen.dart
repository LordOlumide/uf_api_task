import 'package:flutter/material.dart';

class SigninScreen extends StatelessWidget {
  static const screenId = 'Signin screen';

  const SigninScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Sign in screen')),
    );
  }
}
