import 'package:flutter/material.dart';

// routes
import './screens/welcome_screen.dart';
import './screens/signin_screen.dart';
import './screens/signup_screen.dart';

class BookStoreApp extends StatelessWidget {
  const BookStoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BookStore',
      initialRoute: WelcomeScreen.screenId,
      routes: {
        WelcomeScreen.screenId: (context) => const WelcomeScreen(),
        SignupScreen.screenId: (context) => const SignupScreen(),
        SigninScreen.screenId: (context) => const SigninScreen(),
      },
    );
  }
}
