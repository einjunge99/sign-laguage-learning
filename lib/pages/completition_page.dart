import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sign_language_learning/controllers/index.dart';
import 'package:sign_language_learning/controllers/quiz/index.dart';
import 'package:sign_language_learning/pages/home_page.dart';
import 'package:sign_language_learning/repositories/quiz/index.dart';

//TODO: Add disclaimer notifying that lecture wont be marked as completed if score is less than 80%
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
                if (quizState.overview >= 75) {
                  final _selectedLecture =
                      ref.read(lectureController.notifier).state;
                  ref.watch(quizProvider).saveQuiz(lectureId: _selectedLecture);
                }
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
