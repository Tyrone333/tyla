import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _isLogin = true;
  bool _showPasswordConfirmation = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isLogin ? 'Login' : 'Register'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              if (_showPasswordConfirmation)
                Column(
                  children: [
                    TextFormField(
                      controller: _confirmPasswordController,
                      decoration:
                          const InputDecoration(labelText: 'Confirm Password'),
                      obscureText: true,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your password confirmation';
                        }
                        if (value != _passwordController.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    if (_isLogin) {
                      // Perform login logic
                      setState(() {
                        FirebaseAuth.instance.signInWithEmailAndPassword(
                          email: _emailController.text,
                          password: _passwordController.text,
                        );
                      });
                    } else {
                      // Perform register logic
                      setState(() {
                        FirebaseAuth.instance.createUserWithEmailAndPassword(
                          email: _emailController.text,
                          password: _passwordController.text,
                        );
                      });
                    }
                  }
                },
                child: Text(_isLogin ? 'Login' : 'Register'),
              ),
              const SizedBox(height: 16.0),
              TextButton(
                onPressed: () {
                  setState(() {
                    _isLogin = !_isLogin;
                    _showPasswordConfirmation = !_isLogin;
                  });
                },
                child: Text(_isLogin ? 'Register' : 'Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
