import 'package:flutter/material.dart';
import 'package:sign_language_learning/providers.dart';
import 'package:sign_language_learning/widgets/common/input_text.dart';

class RegisterForm extends StatefulWidget {
  final AuthenticationClientNotifier notifier;
  const RegisterForm(this.notifier, {Key? key}) : super(key: key);

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _email = '', _password = '';

  Future<void> _submit() async {
    final isValid = _formKey.currentState?.validate();

    if (isValid ?? false) {
      String? response = await widget.notifier
          .emailAndPasswordSignIn(email: _email, password: _password);
      if (response != null) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          response,
          (_) => false,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Text("Ingresa tus datos"),
            InputText(
              label: 'Correo electrónico',
              keyboardType: TextInputType.emailAddress,
              // fontSize: responsive.relativeDiagonal(1.4),
              onChanged: (String text) {
                _email = text;
              },
              validator: (String? text) {
                if (text?.isEmpty ?? true) {
                  return 'Email is required';
                }
                return null;
              },
            ),
            SizedBox(
              // height: responsive.relativeDiagonal(2),
              height: 2,
            ),
            InputText(
              label: 'Contraseña',
              obscureText: true,
              // fontSize: responsive.relativeDiagonal(1.4),
              onChanged: (String text) {
                _password = text;
              },
              validator: (String? text) {
                if (text?.isEmpty ?? true) {
                  return 'Email is required';
                }
                return null;
              },
            ),
            SizedBox(
              // height: responsive.relativeDiagonal(5),
              height: 5,
            ),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                onPressed: _submit,
                child: const Text(
                  'CREAR CUENTA',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            SizedBox(
              // height: responsive.relativeDiagonal(2),
              height: 2,
            ),
          ],
        ),
      ),
    );
  }
}
