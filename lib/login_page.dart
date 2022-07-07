import 'package:flutter/material.dart';
import 'auth_credentials.dart';

class LoginPage extends StatefulWidget {
  final ValueChanged<LoginCredentials> didProvideCredentials;
  final VoidCallback shouldShowSignUp;
  const LoginPage(
      {Key? key,
      required this.shouldShowSignUp,
      required this.didProvideCredentials})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // 1
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // 2
    return Scaffold(
      // 3
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(
          horizontal: 40,
        ),
        // 4
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            // Login Form
            _loginForm(),

            // 6
            // Sign Up Button
            Container(
              height: 30,
              width: 240,
              alignment: Alignment.bottomCenter,
              child: InkWell(
                onTap: widget.shouldShowSignUp,
                child: const Text(
                  'Don\'t have an account? Sign up.',
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  // 5
  Widget _loginForm() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Username TextField
        TextField(
          controller: _usernameController,
          decoration: const InputDecoration(
            icon: Icon(Icons.mail),
            labelText: 'Username',
          ),
        ),

        // Password TextField
        TextField(
          controller: _passwordController,
          decoration: const InputDecoration(
            icon: Icon(Icons.lock_open),
            labelText: 'Password',
          ),
          obscureText: true,
          keyboardType: TextInputType.visiblePassword,
        ),

        // Login Button
        Container(
          margin: const EdgeInsets.all(24),
          height: 30,
          width: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.blue,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                onTap: _login,
                child: const Text('Login'),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // 7
  void _login() {
    final username = _usernameController.text.trim();
    final password = _passwordController.text.trim();
    final credentials =
        LoginCredentials(username: username, password: password);
    widget.didProvideCredentials(credentials);

    print('username: $username');
    print('password: $password');
  }
}
