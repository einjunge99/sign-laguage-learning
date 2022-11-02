import 'package:flutter/material.dart';
import 'package:sign_language_learning/providers.dart';
import 'package:sign_language_learning/widgets/common/button.dart';
import 'package:sign_language_learning/widgets/common/input_text.dart';

class LoginForm extends StatefulWidget {
  final AuthenticationClientNotifier notifier;
  const LoginForm(this.notifier, {Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _email = '', _password = '';

  Future<void> _submit() async {
    final isValid = _formKey.currentState?.validate();

    if (isValid ?? false) {
      String? response = await widget.notifier
          .emailAndPasswordLogIn(email: _email, password: _password);
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
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Text(
            "Inicia sesión",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(
            height: 10,
          ),
          InputText(
            label: 'Correo electrónico',
            keyboardType: TextInputType.emailAddress,
            onChanged: (String text) {
              _email = text;
            },
          ),
          const SizedBox(
            height: 10,
          ),
          InputText(
            label: 'Contraseña',
            obscureText: true,
            onChanged: (String text) {
              _password = text;
            },
          ),
          const SizedBox(
            height: 10,
          ),
          CustomButton(title: 'INICIAR SESIÓN', onTap: _submit),
          const SizedBox(
            height: 10,
          ),
          Text(
            "Olvidé mi contraseña",
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ],
      ),
    );
  }
}
