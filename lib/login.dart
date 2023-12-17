import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:signup_form_flutter/signup.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() {
    return _LoginState();
  }
}

class _LoginState extends State<Login> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> loginUser(String username, String password) async {
    var loginEndpoint = Uri.parse("http://server.lewibelayneh.com:8989/login");

    var loginData = {
      "username": username,
      "password": password,
    };

    try {
      var response = await http.post(
        loginEndpoint,
        body: jsonEncode(loginData),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        _showDialog("Success", "User logged in successfully");
        // Handle successful login, navigate to the next screen, etc.
      } else if (response.statusCode == 404) {
        _showDialog("User Not Found", "Invalid Username or Password");
      } else {
        _showDialog("Error", "Error logging in user: ${response.statusCode}");
        // Handle login error, show an error message, etc.
      }
    } catch (e) {
      _showDialog("Exception", "Exception during user login: $e");
      // Handle exception, show an error message, etc.
    }
  }

  void _showDialog(String title, String content) {
    showDialog(
      context: context, // Use the context from the State class
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _validateAndLogin() {
    String username = _usernameController.text.trim();
    String password = _passwordController.text.trim();

    if (username.isEmpty || password.isEmpty) {
      _showDialog("Error", "Please enter both username and password.");
    } else {
      loginUser(username, password);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          margin: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _header(),
              _inputField(),
              _forgotPassword(),
              _signup(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _header() {
    return const Column(
      children: [
        Text(
          "Welcome Back",
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        ),
        Text("Enter your credentials to login"),
      ],
    );
  }

  Widget _inputField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          controller: _usernameController,
          decoration: InputDecoration(
            hintText: "Username or Email",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide.none,
            ),
            fillColor: const Color.fromARGB(255, 42, 151, 194).withOpacity(0.1),
            filled: true,
            prefixIcon: const Icon(Icons.person),
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: _passwordController,
          decoration: InputDecoration(
            hintText: "Password",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide.none,
            ),
            fillColor: const Color.fromARGB(255, 42, 151, 194).withOpacity(0.1),
            filled: true,
            prefixIcon: const Icon(Icons.password),
          ),
          obscureText: true,
        ),
        const SizedBox(height: 48),
        ElevatedButton(
          onPressed: () {
            _validateAndLogin();
          },
          style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
            padding: const EdgeInsets.symmetric(vertical: 16),
            backgroundColor: const Color.fromARGB(255, 42, 151, 194),
          ),
          child: const Text(
            "Login",
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        )
      ],
    );
  }

  Widget _forgotPassword() {
    return TextButton(
      onPressed: () {
        // TODO: Implement forgot password functionality
      },
      child: const Text(
        "Forgot password?",
        style: TextStyle(color: Color.fromARGB(255, 42, 151, 194)),
      ),
    );
  }

  Widget _signup() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have an account? "),
        TextButton(
          onPressed: () {
            // TODO: Implement sign up functionality
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Signup()),
            );
          },
          child: const Text(
            "Sign Up",
            style: TextStyle(color: Color.fromARGB(255, 42, 151, 194)),
          ),
        )
      ],
    );
  }
}
