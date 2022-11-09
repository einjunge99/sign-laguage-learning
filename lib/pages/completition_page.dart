import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sign_language_learning/controllers/index.dart';
import 'package:sign_language_learning/controllers/quiz/index.dart';
import 'package:sign_language_learning/pages/home_page.dart';
import 'package:sign_language_learning/repositories/quiz/index.dart';
import 'package:sign_language_learning/widgets/common/button.dart';

class CompletitionPage extends ConsumerWidget {
  const CompletitionPage({Key? key}) : super(key: key);
  static const String routeName = "completetion_page";

  String getCompletitionText(int overview) {
    if (overview < 75) {
      return "Alcanza más del 75% de aciertos para marcar como completada. ¡Llega al 100% para dominarla!";
    }
    if (overview < 99) {
      return "¡Muy bien! Has completado la lección. ¡Llega al 100% para dominarla!";
    }

    return '¡Felicidades! Lección dominada';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quizState = ref.watch(quizControllerProvider);

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        margin: const EdgeInsets.only(bottom: buttonHeight),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Tus resultados",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline3,
            ),
            const SizedBox(height: 20),
            Column(
              children: [
                Text(
                  'Aciertos',
                  style: Theme.of(context).textTheme.headline4,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.track_changes_rounded,
                      color: Colors.blue,
                      size: 50,
                    ),
                    Text(
                      '${quizState.overview}%',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline4,
                    )
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              getCompletitionText(quizState.overview),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: CustomButton(
          onTap: () {
            if (quizState.overview >= 75) {
              final _selectedLecture =
                  ref.read(lectureController.notifier).state;
              ref.watch(quizProvider).saveQuiz(lectureId: _selectedLecture);
              ref.refresh(treeBadgesProvider);
            }
            Navigator.pushNamedAndRemoveUntil(
              context,
              HomePage.routeName,
              (_) => false,
            );
          },
          title: 'REGRESAR A INICIO',
        ),
      ),
    );
  }
}
