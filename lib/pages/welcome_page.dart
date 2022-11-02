import 'package:flutter/material.dart';
import 'package:sign_language_learning/pages/login_page.dart';
import 'package:sign_language_learning/pages/register_page.dart';
import 'package:sign_language_learning/ui/decoration.dart';
import 'package:sign_language_learning/widgets/common/button.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);
  static const String routeName = "welcome_page";

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          margin: const EdgeInsets.only(bottom: buttonHeight * 2),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.network(
                "https://www.sense.org.uk/wp-content/themes/sense-uk/assets/img/sign/o.png",
              ),
              Text(
                "<MI APP>",
                style: Theme.of(context).textTheme.headlineLarge,
                textAlign: TextAlign.center,
              ),
              Text(
                "Abre la puerta al mundo de la lengua de señas",
                style: Theme.of(context).textTheme.headlineSmall,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        bottomSheet: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomButton(
                title: 'CREAR CUENTA',
                onTap: () {
                  Navigator.pushNamed(context, RegisterPage.routeName);
                },
              ),
              const SizedBox(height: 10),
              CustomButton(
                variant: ButtonVariant.secondary,
                title: 'YA TENGO UNA CUENTA',
                onTap: () {
                  Navigator.pushNamed(context, LoginPage.routeName);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
