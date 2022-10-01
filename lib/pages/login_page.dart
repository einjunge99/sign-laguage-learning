import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:riverpod_messages/riverpod_messages.dart';
import 'package:sign_language_learning/providers.dart';
import 'package:sign_language_learning/store/reducers/snackbar.dart';
import 'package:sign_language_learning/widgets/forms/login_form.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  static const String routeName = "login_page";
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(authenticationClientStateProvider.notifier);
    return Scaffold(
      body: MessageSnackbarListener(
        provider: authenticationClientStateProvider,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ref.watch(
                  exampleStateNotifierProvider.select((value) => value.loading))
              ? const CircularProgressIndicator()
              : Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    LoginForm(notifier),
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
                      label: Text("INICIAR SESIÓN CON GOOGLE"),
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
      ),
    );
  }
}
