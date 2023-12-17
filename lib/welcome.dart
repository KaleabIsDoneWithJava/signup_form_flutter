import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  final String username;

  WelcomePage({required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome Back, $username!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Inside your Welcome widget or any other page in the navigation stack
                Navigator.popUntil(context, (route) => route.isFirst);

                // Navigator.pop(context); // Navigate back to the previous page
              },
              style: ElevatedButton.styleFrom(
                shape: const StadiumBorder(),
                padding: const EdgeInsets.symmetric(vertical: 16),
                backgroundColor: Color.fromARGB(255, 194, 42, 42),
              ),
              child: Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
