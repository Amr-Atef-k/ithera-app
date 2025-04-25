import 'package:flutter/material.dart';
import 'class/users.dart';
import 'database_helper.dart';
import 'SignInScreen.dart';

class SignUpScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _firstName = TextEditingController();
  final _lastName = TextEditingController();
  final _email = TextEditingController();
  final _phone = TextEditingController();
  final _password = TextEditingController();
  final _confirmPassword = TextEditingController();

  final dbHelper = DatabaseHelper();

  void _signUp(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      if (_password.text != _confirmPassword.text) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Passwords do not match')),
        );
        return;
      }

      final user = User(
        firstName: _firstName.text.trim(),
        lastName: _lastName.text.trim(),
        email: _email.text.trim(),
        phone: _phone.text.trim(),
        password: _password.text.trim(),
      );

      try {
        await dbHelper.insertUser(user);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Account created. Please log in.')),
        );

        // Navigate to SignInScreen after successful sign-up
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => SignInScreen()),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.toString()}')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              SizedBox(height: 40),
              Center(
                child: Text(
                  'Sign Up',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _firstName,
                      decoration: InputDecoration(labelText: 'First Name'),
                      validator: (val) => val!.isEmpty ? 'Required' : null,
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      controller: _lastName,
                      decoration: InputDecoration(labelText: 'Last Name'),
                      validator: (val) => val!.isEmpty ? 'Required' : null,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _email,
                decoration: InputDecoration(labelText: 'Email'),
                validator: (val) {
                  if (val!.isEmpty) return 'Required';
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(val)) {
                    return 'Enter a valid email';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _phone,
                decoration: InputDecoration(labelText: 'Phone'),
                validator: (val) => val!.isEmpty ? 'Required' : null,
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _password,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (val) => val!.isEmpty ? 'Required' : null,
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _confirmPassword,
                decoration: InputDecoration(labelText: 'Confirm Password'),
                obscureText: true,
                validator: (val) => val!.isEmpty ? 'Required' : null,
              ),
              SizedBox(height: 24),
              ElevatedButton(
                // This button signs the user up, then redirects to SignInScreen
                onPressed: () => _signUp(context),
                child: Text('Sign Up'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}