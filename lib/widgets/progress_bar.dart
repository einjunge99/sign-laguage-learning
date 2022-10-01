import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sign_language_learning/providers.dart';

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
    final counter = ref.watch(newPageProvider);
    return Container(
      width: double.infinity,
      height: 35,
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xFF3F4768), width: 3),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Stack(
        children: [
          // LayoutBuilder provide us the available space for the conatiner
          // constraints.maxWidth needed for our animation
          LayoutBuilder(
            builder: (context, constraints) => Container(
              // from 0 to 1 it takes 60s
              // width: constraints.maxWidth * controller.animation.value,
              width: constraints.maxWidth * counter / totalPages,
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
