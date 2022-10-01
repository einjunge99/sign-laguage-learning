import 'package:flutter/material.dart';
import 'package:sign_language_learning/pages/home_page.dart';

class CompletitionPage extends StatelessWidget {
  const CompletitionPage({Key? key}) : super(key: key);
  static const String routeName = "completetion_page";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "¡Felicidades!",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  HomePage.routeName,
                  (_) => false,
                );
              },
              child: Text("CONTINUAR"),
            ),
          ],
        ),
      ),
    );
  }
}
