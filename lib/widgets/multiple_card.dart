import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sign_language_learning/controllers/quiz/index.dart';
import 'package:sign_language_learning/models/question.dart';
import 'package:sign_language_learning/widgets/answer_card.dart';
import 'package:sign_language_learning/widgets/common/button.dart';
import 'package:sign_language_learning/widgets/video_card.dart';

class MultipleCard extends HookConsumerWidget {
  const MultipleCard({Key? key, required this.question}) : super(key: key);

  final Question question;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(quizControllerProvider);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      margin: const EdgeInsets.only(bottom: buttonHeight),
      child: Column(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Elige la opción correcta',
                style: Theme.of(context).textTheme.headline6,
              ),
              Text(
                'Selecciona la opción que represente al video',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
          const SizedBox(height: 20),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  VideoCard(videoUrl: question.videoId),
                  Divider(
                    color: Colors.grey[200],
                    height: 32.0,
                    thickness: 2.0,
                    indent: 20.0,
                    endIndent: 20.0,
                  ),
                  Column(
                    children: question.options!
                        .map(
                          (e) => AnswerCard(
                            answer: e,
                            isSelected: e == state.selectedAnswer,
                            isCorrect: e == question.answer,
                            isDisplayingAnswer: state.answered,
                            onTap: () => ref
                                .read(quizControllerProvider.notifier)
                                .submitAnswer(question, e),
                          ),
                        )
                        .toList(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
