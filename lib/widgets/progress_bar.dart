import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sign_language_learning/controllers/quiz/index.dart';

const kDefaultPadding = 20.0;
const kPrimaryGradient = LinearGradient(
  colors: [Colors.green, Colors.green, Colors.green],
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  stops: [0.45, 0.55, 0.65],
);

//TODO: add animation: https://www.youtube.com/watch?v=R3Lhqk_IX7g
class ProgressBar extends ConsumerWidget {
  const ProgressBar({
    Key? key,
    required this.totalPages,
  }) : super(key: key);

  final int totalPages;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(quizControllerProvider);
    return Container(
      width: double.infinity,
      height: 20,
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFF3F4768), width: 3),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Stack(
        children: [
          LayoutBuilder(
            builder: (context, constraints) => Container(
              width: constraints.maxWidth * state.questionCounter / totalPages,
              decoration: BoxDecoration(
                gradient: kPrimaryGradient,
                borderRadius: BorderRadius.circular(50),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
