import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sign_language_learning/controllers/quiz/index.dart';
import 'package:sign_language_learning/pages/home_page.dart';

class CompletitionPage extends ConsumerWidget {
  const CompletitionPage({Key? key}) : super(key: key);
  static const String routeName = "completetion_page";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quizState = ref.watch(quizControllerProvider);

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              "¡Nivel completado!",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '${quizState.overview}% de aciertos',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
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
