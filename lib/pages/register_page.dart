import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sign_language_learning/pages/home_page.dart';
import 'package:sign_language_learning/providers.dart';
import 'package:sign_language_learning/widgets/forms/register_form.dart';

class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);
  static const String routeName = "register_page";

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(authenticationClientStateProvider.notifier);
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            RegisterForm(notifier),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                onPrimary: Colors.black,
                minimumSize: Size(double.infinity, 50),
              ),
              icon: FaIcon(
                FontAwesomeIcons.google,
                color: Colors.red,
              ),
              label: Text("REGISTRARSE CON GOOGLE"),
              onPressed: () async {
                String? response = await notifier.googleSignIn();
                if (response != null) {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    response,
                    (_) => false,
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
