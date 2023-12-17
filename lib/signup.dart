import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:signup_form_flutter/models/user_data.dart';
import 'package:signup_form_flutter/data/users.dart';
import 'package:http/http.dart' as http;

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

// Function to log in user using API
  Future<void> loginUser(String username, String password) async {
    // API endpoint for user login
    var loginEndpoint = Uri.parse("http://server.lewibelayneh.com:8989/login");

    // Prepare data for API request
    var loginData = {
      "username": username,
      "password": password,
    };

    try {
      // Send POST request to login user
      var response = await http.post(
        loginEndpoint,
        body: jsonEncode(loginData),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        print("User logged in successfully");
        // Handle successful login, navigate to next screen, etc.
      } else {
        print("Error logging in user: ${response.statusCode}");
        // Handle login error, show error message, etc.
      }
    } catch (e) {
      print("Exception during user login: $e");
      // Handle exception, show error message, etc.
    }
  }

  // Function to register user using API
  Future<void> registerUser() async {
    String username = _usernameController.text.trim();
    String email = _emailController.text.trim();
    String password = _passwordController.text;
    String confirmPassword = _confirmPasswordController.text;

    RegExp emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    if (!emailRegex.hasMatch(email)) {
      setState(() {
        emailErrorText = "Invalid email address. Try again.";
      });
      return;
    }

    if (password != confirmPassword) {
      setState(() {
        passwordErrorText = "Passwords do not match.";
      });
      return;
    }

    // Iterating through the saved list of users
    for (UserData user in users) {
      if (user.username == username) {
        setState(() {
          usernameErrorText = "Username already taken.";
        });
        return;
      }
      if (user.email == email) {
        setState(() {
          emailErrorText = "User already registered. Login instead.";
        });
        return;
      }
    }

    //users.add(UserData(username, email, password));
    // Adding the newly registered user

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
        print("User registered successfully");

        // If registration is successful, you might want to handle login here
        // redirect to loginpage
        //await loginUser(username, password);
      } else {
        print("Error registering user: ${response.statusCode}");
        // Handle error, show error message, etc.
      }
    } catch (e) {
      print("Exception during user registration: $e");
      // Handle exception, show error message, etc.
    }
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
                      // String errorMessage = registerUser();
                      // if (errorMessage.isNotEmpty) {
                      //   // If there's an error, show the error message in a dialog
                      //   //showErrorMessageDialog(errorMessage);
                      //   print(errorMessage);
                      // } else {
                      //   // Continue with the signup process
                      //   // ...
                      //   print("Signing up...");
                      // }
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
