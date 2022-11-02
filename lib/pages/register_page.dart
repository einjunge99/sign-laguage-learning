import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sign_language_learning/providers.dart';
import 'package:sign_language_learning/widgets/common/button.dart';
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
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            RegisterForm(notifier),
            const Divider(height: 50),
            CustomButton(
              title: 'INICIAR SESIÓN CON GOOGLE',
              variant: ButtonVariant.secondary,
              icon: const FaIcon(
                FontAwesomeIcons.google,
                color: Colors.red,
              ),
              onTap: () async {
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
