import 'package:flutter/material.dart';
import 'package:signup_form_flutter/login.dart';
import 'package:signup_form_flutter/signup.dart';

void main() {
  runApp(const MaterialApp(home: Login()));
}

// class Signup extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Signup(),
//     );
//   }
// }

class MobileAppsAssignmentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _header(),
                _assignmentImage(),
                _buttons(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _header() {
    return const Column(
      children: [
        Text(
          "Mobile Applications Assignment",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Text("Submitted to Ashenafi", style: TextStyle(fontSize: 16)),
      ],
    );
  }

  Widget _assignmentImage() {
    return Container(
      height: 200,
      width: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: const DecorationImage(
          image: NetworkImage(
              "https://example.com/your_assignment_image.jpg"), // Replace with your actual image URL
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buttons() {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            // TODO: Implement sign up functionality
            const Signup();
          },
          style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
            padding: const EdgeInsets.symmetric(vertical: 16),
            backgroundColor: const Color.fromARGB(255, 42, 151, 194),
          ),
          child: const Text(
            "Sign Up",
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            // TODO: Implement login functionality
            const Login();
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
        ),
      ],
    );
  }
}

// void main() {
//   runApp(MobileAppsAssignmentPage());
// }
