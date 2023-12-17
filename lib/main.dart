import 'package:flutter/material.dart';
import 'package:signup_form_flutter/login.dart';
import 'package:signup_form_flutter/signup.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MobileAppsAssignmentPage(),
    );
  }
}

class MobileAppsAssignmentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _header(),
              // _assignmentImage(),
              _buttons(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _header() {
    return Column(
      children: <Widget>[
        const SizedBox(height: 120.0),
        const Text(
          "Mobile Applications Assignment",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 48,
        ),
        Text(
          "Submitted by: Kaleab Teshome",
          style: TextStyle(fontSize: 15, color: Colors.grey.shade700),
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          "Id: JC3566",
          style: TextStyle(fontSize: 15, color: Colors.grey.shade700),
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          "Section: A",
          style: TextStyle(fontSize: 15, color: Colors.grey.shade700),
        )
      ],
    );
  }

  Widget _assignmentImage() {
    return Container(
      height: 350,
      width: 350,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: const DecorationImage(
          image: AssetImage("assets/mobile_login_bro.png"),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buttons(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Signup()),
            );
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
        Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          const SizedBox(height: 20),
          Text(
            "or",
            style: TextStyle(fontSize: 15, color: Colors.grey.shade700),
          ),
          const SizedBox(height: 20),
        ]),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Login()),
            );
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
