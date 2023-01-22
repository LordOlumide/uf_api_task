import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/login/login_provider.dart';
import '../providers/login/login_state.dart';
import '../exceptions/network_request_exception.dart';
import './home_screen.dart';

class SigninScreen extends StatefulWidget {
  static const screenId = 'Signin screen';

  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  late final TextEditingController _usernameController;
  late final TextEditingController _passwordController;
  late final LoginProvider _loginProvider;

  late FocusNode _usernameFocusNode;
  late FocusNode _passwordFocusNode;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
    _loginProvider = LoginProvider();
    _loginProvider.addListener(loginStateListener);

    _usernameFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
  }

  loginStateListener() {
    if (_loginProvider.currentState is LoginLoadedState) {
      print('signed in success');
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (_) => const HomeScreen()));
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();

    _loginProvider.removeListener(loginStateListener);
    _loginProvider.dispose();

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
    return ListenableProvider<LoginProvider>.value(
      value: _loginProvider,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Sign in'),
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

              Selector<LoginProvider, LoginState>(
                selector: (_, provider) => provider.currentState,
                builder: (_, state, __) {
                  return SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        unfocusAllNodes();
                        // try {
                        if (state is! LoginLoadingState) {
                          _loginProvider.login(
                            username: _usernameController.text,
                            password: _passwordController.text,
                          );
                        }
                        // } on NetworkRequestException catch (e) {
                        //   if (mounted) {
                        //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        //       content: Text(e.message),
                        //     ));
                        //   }
                        // }
                      },
                      child: state is LoginLoadingState
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
                              'Sign in',
                              style: TextStyle(fontSize: 20),
                            ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
