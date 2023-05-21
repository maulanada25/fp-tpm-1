import 'package:flutter/material.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';
import 'package:projecttpm/menu.dart';
import 'database_helper.dart';
import 'dart:convert';

class LoginPageOi extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPageOi> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _login() async {
    if (_formKey.currentState!.validate()) {
      // Encrypt the password
      // final password = encrypt.Encrypted(_passwordController.text);
      final passwordBytes = utf8.encode(_passwordController.text);
      final passwordBase64 = base64.encode(passwordBytes);

      // Store the login credentials in the SQLite database
      await DatabaseHelper.instance.insertLoginCredentials(
        _usernameController.text,
        passwordBase64,
      );

      // Clear the username and password fields
      _usernameController.clear();
      _passwordController.clear();

      // Navigate to the home page or perform other actions
      // after successful login
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page Gais'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(labelText: 'Username'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a username';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Password'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a password';
                  }
                  return null;
                },
                obscureText: true,
              ),
              SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: _login,
                    child: Text('Login'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      
                    },
                    child: Text('Register'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
