import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:sign_language_learning/data/authentication_client.dart';
import 'package:sign_language_learning/pages/home_page.dart';
import 'package:sign_language_learning/pages/login_page.dart';
import 'package:sign_language_learning/pages/register_page.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);
  static const String routeName = "welcome_page";

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final _authenticationClient = GetIt.instance<AuthenticationClient>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.network(
              "https://www.sense.org.uk/wp-content/themes/sense-uk/assets/img/sign/o.png",
            ),
            Text(
              "Lorem ipsum",
              textAlign: TextAlign.center,
            ),
            Text(
              "Lorem ipsum",
              textAlign: TextAlign.center,
            ),
            ElevatedButton(
              child: Text('Soy nuevo aquí'),
              onPressed: () {
                Navigator.pushNamed(context, RegisterPage.routeName);
              },
            ),
            ElevatedButton(
              child: Text('Ya tengo una cuenta'),
              onPressed: () {
                Navigator.pushNamed(context, LoginPage.routeName);
              },
            ),
          ],
        ),
      ),
    );
  }
}
