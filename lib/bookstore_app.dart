import 'package:flutter/material.dart';

// routes
import './screens/welcome_screen.dart';

class BookStoreApp extends StatelessWidget {
  const BookStoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'BookStore',
      home: WelcomeScreen(),
    );
  }
}
