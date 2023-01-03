import 'package:flutter/material.dart';
import '../models/user.dart';
import '../helpers/network_helper.dart';
import '../exceptions/network_request_exception.dart';

class SignupScreen extends StatefulWidget {
  static const screenId = 'Signup screen';

  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  late final TextEditingController _usernameController;
  late final TextEditingController _passwordController;

  late FocusNode _usernameFocusNode;
  late FocusNode _passwordFocusNode;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();

    _usernameFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();

    _usernameFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  void unfocusAllNodes() {
    _usernameFocusNode.unfocus();
    _passwordFocusNode.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Username TextField
            TextField(
              controller: _usernameController,
              focusNode: _usernameFocusNode,
              decoration: const InputDecoration(
                hintText: 'Username',
                border: OutlineInputBorder(borderSide: BorderSide(width: 2)),
              ),
            ),
            const SizedBox(height: 30),

            // Password TextField
            TextField(
              controller: _passwordController,
              focusNode: _passwordFocusNode,
              decoration: const InputDecoration(
                hintText: 'Password',
                border: OutlineInputBorder(borderSide: BorderSide(width: 2)),
              ),
            ),
            const SizedBox(height: 30),

            ElevatedButton(
              onPressed: () async {
                unfocusAllNodes();
                try {
                  final User currentUser = await NetworkHelper.signup(
                    username: _usernameController.text,
                    password: _passwordController.text,
                  );
                  print('currentUser is: ${currentUser.toString()}');
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Sign up success'),
                    ));
                  }
                } on NetworkRequestException catch (e) {
                  print('Front catching error');
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(e.message),
                    ));
                  }
                }
              },
              child: const Text(
                'Sign up',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
