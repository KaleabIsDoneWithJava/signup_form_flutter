import 'dart:convert';
//import 'dart:io';
import 'package:flutter/material.dart';
import 'package:signup_form_flutter/login.dart';
//import 'package:signup_form_flutter/models/user_data.dart';
//import 'package:signup_form_flutter/data/users.dart';
import 'package:http/http.dart' as http;
import 'package:signup_form_flutter/welcome.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() {
    return _SignupState();
  }
}

class _SignupState extends State<Signup> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  String usernameErrorText = "";
  String emailErrorText = "";
  String passwordErrorText = "";

  // Function to register user using API
  Future<void> registerUser() async {
    String username = _usernameController.text.trim();
    String email = _emailController.text.trim();
    String password = _passwordController.text;
    String confirmPassword = _confirmPasswordController.text;

    void clearInputFields() {
      _usernameController.clear();
      _emailController.clear();
      _passwordController.clear();
      _confirmPasswordController.clear();
    }

    void navigateToWelcome(String username) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Welcome(username: username),
        ),
      );
    }

    void navigateToLogin(String username) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const Login(),
        ),
      );
    }

    RegExp emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    if (!emailRegex.hasMatch(email)) {
      // setState(() {
      //   emailErrorText = "Invalid email address. Try again.";
      // });
      _showDialog("Invalid email", "Invalid email address. Try again.");
      _emailController.clear();
      //clearInputFields();
      return;
    }

    if (password != confirmPassword) {
      setState(() {
        passwordErrorText = "Passwords do not match.";
      });
      _showDialog("Not a match", "Passwords do not match.");
      _passwordController.clear();
      _confirmPasswordController.clear();
      //clearInputFields();

      return;
    }

    var userData = {
      "username": username,
      "password": password,
    };

    try {
      // API endpoint for user registration
      var createUserEndpoint =
          Uri.parse("http://server.lewibelayneh.com:8989/create_user");

      // Send POST request to create user
      var response = await http.post(
        createUserEndpoint,
        body: jsonEncode(userData),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        navigateToWelcome(username);
        // Inside your login or signup page
        _showDialog("Success", "User registered in successfully");

        // Handle successful login, navigate to the next screen, etc.
      } else if (response.statusCode == 404) {
        _showDialog(
            "Account Not Found", "Don't have an account? Register below.");
        clearInputFields();
      } else if (response.statusCode == 408) {
        _showDialog("Slow Network", "The Reqeust timed out.");
      } else if (response.statusCode == 409) {
        navigateToLogin(username);
        _showDialog("User already exists", "Login instead.");
      } else if (response.statusCode > 400 && response.statusCode < 500) {
        _showDialog(
            "Signup Error", "Invalid Username or Password.\n Try again.");
      } else {
        _showDialog("Error", "Error logging in user: ${response.statusCode}");
        // Handle login error, show an error message, etc.
      }
    } catch (e) {
      _showDialog("Exception", "Exception during user login: $e");
      // Handle exception, show an error message, etc.
    }

    //clearInputFields();
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            height: MediaQuery.of(context).size.height - 50,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    const SizedBox(height: 60.0),
                    const Text(
                      "Sign up",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Create your account",
                      style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                    )
                  ],
                ),
                Column(
                  children: <Widget>[
                    TextField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                        hintText: "Username",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide.none,
                        ),
                        fillColor: usernameErrorText.isNotEmpty
                            ? Colors.red.withOpacity(0.1)
                            : const Color.fromARGB(255, 42, 151, 194)
                                .withOpacity(0.1),
                        filled: true,
                        prefixIcon: const Icon(Icons.person),
                      ),
                    ),
                    //Conditoinally rendering error message
                    if (usernameErrorText.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Text(
                          usernameErrorText,
                          style: const TextStyle(color: Colors.red),
                        ),
                      ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        hintText: "Email",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide.none,
                        ),
                        fillColor: emailErrorText.isNotEmpty
                            ? Colors.red.withOpacity(0.1)
                            : const Color.fromARGB(255, 42, 151, 194)
                                .withOpacity(0.1),
                        filled: true,
                        prefixIcon: const Icon(Icons.email),
                      ),
                    ),
                    //Conditoinally rendering error message
                    if (emailErrorText.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Text(
                          emailErrorText,
                          style: const TextStyle(color: Colors.red),
                        ),
                      ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        hintText: "Password",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide.none,
                        ),
                        fillColor: passwordErrorText.isNotEmpty
                            ? Colors.red.withOpacity(0.1)
                            : const Color.fromARGB(255, 42, 151, 194)
                                .withOpacity(0.1),
                        filled: true,
                        prefixIcon: const Icon(Icons.password),
                      ),
                      obscureText: true,
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: _confirmPasswordController,
                      decoration: InputDecoration(
                        hintText: "Confirm Password",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide.none,
                        ),
                        fillColor: passwordErrorText.isNotEmpty
                            ? Colors.red.withOpacity(0.1)
                            : const Color.fromARGB(255, 42, 151, 194)
                                .withOpacity(0.1),
                        filled: true,
                        prefixIcon: const Icon(Icons.password),
                      ),
                      obscureText: true,
                    ),
                    //Conditoinally rendering error message
                    if (passwordErrorText.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Text(
                          passwordErrorText,
                          style: const TextStyle(color: Colors.red),
                        ),
                      ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.only(top: 3, left: 3),
                  child: ElevatedButton(
                    onPressed: () {
                      registerUser();
                    },
                    style: ElevatedButton.styleFrom(
                      shape: const StadiumBorder(),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: const Color.fromARGB(255, 42, 151, 194),
                    ),
                    child: const Text(
                      "Sign up",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text("Already have an account?"),
                    TextButton(
                      onPressed: () {
                        // TODO: Implement login navigation
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Login()),
                        );
                      },
                      child: const Text(
                        "Login",
                        style: TextStyle(
                          color: Color.fromARGB(255, 42, 151, 194),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}
