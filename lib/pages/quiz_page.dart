import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sign_language_learning/controllers/index.dart';
import 'package:sign_language_learning/controllers/quiz/index.dart';
import 'package:sign_language_learning/controllers/quiz/state.dart';
import 'package:sign_language_learning/models/question.dart';
import 'package:sign_language_learning/pages/completition_page.dart';
import 'package:sign_language_learning/repositories/quiz/index.dart';
import 'package:sign_language_learning/widgets/common/button.dart';
import 'package:sign_language_learning/widgets/quiz_questions.dart';

final quizQuestionsProvider = FutureProvider.autoDispose<List<Question>>((ref) {
  final _selectedLecture = ref.read(lectureController.notifier).state;
  return ref.watch(quizProvider).getExercises(lectureId: _selectedLecture);
});

class QuizPage extends HookConsumerWidget {
  const QuizPage({Key? key}) : super(key: key);
  static const String routeName = "quiz_page";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quizQuestions = ref.watch(quizQuestionsProvider);
    final pageController = usePageController();
    return SafeArea(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: quizQuestions.when(
            data: (questions) => _buildBody(ref, pageController, questions),
            error: (error, _) => const Center(
              child: Text("There was an error..."),
            ),
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
          ),
          bottomSheet: quizQuestions.maybeWhen(
            data: (questions) {
              final quizState = ref.watch(quizControllerProvider);

              if (quizState.status == QuizStatus.complete) {
                return const SizedBox.shrink();
              }

              if (!pageController.hasClients ||
                  (pageController.page?.toInt() ?? 0) + 1 < questions.length) {
                return CustomButton(
                  title: "SIGUIENTE",
                  onTap: !quizState.answered
                      ? null
                      : () {
                          ref
                              .read(quizControllerProvider.notifier)
                              .nextQuestion(
                                questions,
                                pageController.page?.toInt() ?? 0,
                              );
                          pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeIn,
                          );
                        },
                );
              }

              return CustomButton(
                title: "VER RESULTADOS",
                onTap: () {
                  ref.read(quizControllerProvider.notifier).nextQuestion(
                        questions,
                        pageController.page?.toInt() ?? 0,
                      );
                },
              );
            },
            orElse: () => const SizedBox.shrink(),
          ),
        ),
      ),
    );
  }
}

Widget _buildBody(
  WidgetRef ref,
  PageController pageController,
  List<Question> questions,
) {
  final quizState = ref.watch(quizControllerProvider);
  return quizState.status == QuizStatus.complete
      ? const CompletitionPage()
      : QuizQuestions(
          pageController: pageController,
          state: quizState,
          questions: questions,
        );
}
