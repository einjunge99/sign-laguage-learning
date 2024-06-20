import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sign_language_learning/common/enums/question_type.dart';
import 'package:sign_language_learning/controllers/quiz/state.dart';
import 'package:sign_language_learning/models/question.dart';
import 'package:sign_language_learning/widgets/exercise_card.dart';
import 'package:sign_language_learning/widgets/multiple_card.dart';
import 'package:sign_language_learning/widgets/progress_bar.dart';

class QuizQuestions extends HookConsumerWidget {
  final PageController pageController;
  final QuizState state;
  final List<Question> questions;

  const QuizQuestions({
    Key? key,
    required this.pageController,
    required this.state,
    required this.questions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: IconButton(
                    padding: const EdgeInsets.all(0.0),
                    onPressed: () {
                      Navigator.maybePop(context);
                    },
                    icon: const Icon(
                      Icons.close,
                      size: 40,
                    ),
                  ),
                ),
                Expanded(
                  flex: 8,
                  child: ProgressBar(
                    totalPages: questions.length,
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 20,
          child: PageView.builder(
            controller: pageController,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: questions.length,
            itemBuilder: (BuildContext context, int index) {
              final question = questions[index];

              if (question.type == QuestionType.multiple) {
                return MultipleCard(
                  question: question,
                );
              }

              return ExerciseCard(
                title: question.question,
                label: question.key!,
                videoId: question.videoId,
                pageController: pageController,
                questions: questions,
              );
            },
          ),
        ),
      ],
    );
  }
}
