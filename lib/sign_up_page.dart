import 'package:flutter/material.dart';

import 'auth_credentials.dart';

class SignUpPage extends StatefulWidget {
  final VoidCallback shouldShowLogin;
  final ValueChanged<SignUpCredentials> didProvideCredentials;
  const SignUpPage(
      {Key? key,
      required this.shouldShowLogin,
      required this.didProvideCredentials})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(
          horizontal: 40,
        ),
        child: Stack(
          children: [
            // Sign Up Form
            _signUpForm(),

            // Login Button
            Container(
              alignment: Alignment.bottomCenter,
              child: InkWell(
                onTap: widget.shouldShowLogin,
                child: const Text(
                  'Already have an account? Login.',
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _signUpForm() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Username TextField
        TextField(
          controller: _usernameController,
          decoration: const InputDecoration(
            icon: Icon(Icons.person),
            labelText: 'Username',
          ),
        ),

        // Email TextField
        TextField(
          controller: _emailController,
          decoration: const InputDecoration(
            icon: Icon(Icons.mail),
            labelText: 'Email',
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

        // Sign Up Button
        Container(
          margin: const EdgeInsets.all(8),
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
                onTap: _signUp,
                child: const Text('Sign Up'),
              ),
            ],
          ),
        )
      ],
    );
  }

  void _signUp() {
    final username = _usernameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final credentials =
        SignUpCredentials(username: username, email: email, password: password);
    widget.didProvideCredentials(credentials);

    print('username: $username');
    print('email: $email');
    print('password: $password');
  }
}
