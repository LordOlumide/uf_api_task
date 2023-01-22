import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/user.dart';
import '../providers/signup/signup_provider.dart';
import '../providers/signup/signup_state.dart';
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
  late final SignupProvider _signupProvider;

  late final GlobalKey<FormState> _formKey;

  late FocusNode _usernameFocusNode;
  late FocusNode _passwordFocusNode;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
    _signupProvider = SignupProvider();
    _signupProvider.addListener(signupStateListener);

    _formKey = GlobalKey<FormState>();

    _usernameFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
  }

  signupStateListener() {
    if (_signupProvider.currentState is SignupLoadedState) {
      print('signed in success');
      Navigator.of(context).pop();
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _signupProvider.removeListener(signupStateListener);
    _signupProvider.dispose();

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
    return ListenableProvider<SignupProvider>.value(
      value: _signupProvider,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Sign Up'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Username TextField
                TextFormField(
                  controller: _usernameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Username cannot be empty';
                    } else if (value.length < 4) {
                      return 'Username length cannot be less than 6';
                    }
                    return null;
                  },
                  focusNode: _usernameFocusNode,
                  decoration: const InputDecoration(
                    hintText: 'Username',
                    border:
                        OutlineInputBorder(borderSide: BorderSide(width: 2)),
                  ),
                ),
                const SizedBox(height: 30),

                // Password TextField
                TextFormField(
                  controller: _passwordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password cannot be empty';
                    } else if (value.length < 6) {
                      return 'Password length cannot be less than 6';
                    }
                    return null;
                  },
                  focusNode: _passwordFocusNode,
                  decoration: const InputDecoration(
                    hintText: 'Password',
                    border:
                        OutlineInputBorder(borderSide: BorderSide(width: 2)),
                  ),
                ),
                const SizedBox(height: 30),

                Selector<SignupProvider, SignupState>(
                  selector: (_, provider) => _signupProvider.currentState,
                  builder: (_, state, __) {
                    return ElevatedButton(
                      onPressed: () async {
                        unfocusAllNodes();
                        if (state is! SignupLoadingState) {
                          if (_formKey.currentState!.validate()) {
                            _signupProvider.signup(
                              username: _usernameController.text,
                              password: _passwordController.text,
                            );
                          }
                        }
                      },
                      child: state is SignupLoadingState
                          ? const SizedBox(
                              height: 18,
                              width: 18,
                              child: CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation(Colors.white),
                                strokeWidth: 2,
                              ),
                            )
                          : const Text(
                              'Sign up',
                              style: TextStyle(fontSize: 20),
                            ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
