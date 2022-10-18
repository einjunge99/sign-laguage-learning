import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sign_language_learning/controllers/quiz/index.dart';
import 'package:sign_language_learning/controllers/quiz/state.dart';
import 'package:sign_language_learning/models/question.dart';
import 'package:sign_language_learning/pages/completition_page.dart';
import 'package:sign_language_learning/repositories/quiz/index.dart';
import 'package:sign_language_learning/widgets/common/button.dart';
import 'package:sign_language_learning/widgets/quiz_questions.dart';

final quizQuestionsProvider = FutureProvider.autoDispose<List<Question>>(
    (ref) => ref.watch(quizProvider).getQuestions(level: ''));

class QuizPage extends HookConsumerWidget {
  const QuizPage({Key? key}) : super(key: key);
  static const String routeName = "quiz_page";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quizQuestions = ref.watch(quizQuestionsProvider);
    final pageController = usePageController();
    return Container(
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
            if (!quizState.answered) return const SizedBox.shrink();
            return CustomButton(
              title: pageController.page!.toInt() + 1 < questions.length
                  ? "Siguiente"
                  : "Ver resultados",
              onTap: () {
                ref
                    .read(quizControllerProvider.notifier)
                    .nextQuestion(questions, pageController.page!.toInt());
                if (pageController.page!.toInt() + 1 < questions.length) {
                  pageController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeIn,
                  );
                }
              },
            );
          },
          orElse: () => const SizedBox.shrink(),
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