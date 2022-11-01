import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sign_language_learning/controllers/index.dart';
import 'package:sign_language_learning/controllers/quiz/index.dart';
import 'package:sign_language_learning/pages/level_page.dart';
import 'package:sign_language_learning/pages/quiz_page.dart';

class CircularBadge extends ConsumerWidget {
  const CircularBadge(
      {Key? key,
      required this.uid,
      required this.title,
      required this.badgeColor,
      required this.imageUrl})
      : super(key: key);

  final String uid;
  final String title;
  final Color badgeColor;
  final String imageUrl;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const size = 125.0;
    return GestureDetector(
      onTap: () {
        ref.read(lectureController.notifier).state = uid;
        Navigator.pushNamed(
          context,
          QuizPage.routeName,
        );
      },
      child: Column(
        children: [
          Container(
            width: size,
            height: size,
            child: Stack(
              children: [
                Container(
                  width: size,
                  height: size,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFFE4E5E5),
                  ),
                ),
                Center(
                  child: Container(
                    width: size - 20,
                    height: size - 20,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Container(
                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: badgeColor,
                          shape: BoxShape.circle,
                        ),
                        child: Image.network(
                          imageUrl,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Text(title)
        ],
      ),
    );
  }
}
