import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sign_language_learning/common/enums/question_type.dart';
import 'package:sign_language_learning/controllers/quiz/index.dart';
import 'package:sign_language_learning/controllers/quiz/state.dart';
import 'package:sign_language_learning/models/question.dart';
import 'package:sign_language_learning/widgets/answer_card.dart';
import 'package:sign_language_learning/widgets/exercise_card.dart';
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
                    onPressed: () {},
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
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      // 'Question ${index + 1} of ${questions.length}',
                      question.question,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Divider(
                      color: Colors.grey[200],
                      height: 32.0,
                      thickness: 2.0,
                      indent: 20.0,
                      endIndent: 20.0,
                    ),
                    Column(
                      children: question.answers!
                          .map(
                            (e) => AnswerCard(
                              answer: e,
                              isSelected: e == state.selectedAnswer,
                              isCorrect: e == question.correctAnswer,
                              isDisplayingAnswer: state.answered,
                              onTap: () => ref
                                  .read(quizControllerProvider.notifier)
                                  .submitAnswer(question, e),
                            ),
                          )
                          .toList(),
                    ),
                  ],
                );
              }

              return ExerciseCard(
                  title: question.question,
                  videoID: question.key,
                  pageController: pageController,
                  questions: questions);

              return Center(
                child: Text(
                  'Question: ${question.question}',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
