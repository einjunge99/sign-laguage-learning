import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sign_language_learning/controllers/index.dart';
import 'package:sign_language_learning/pages/quiz_page.dart';

class CircularBadge extends ConsumerWidget {
  const CircularBadge({
    Key? key,
    required this.uid,
    required this.title,
    required this.badgeColor,
    required this.imageUrl,
    required this.isCompleted,
  }) : super(key: key);

  final String uid;
  final String title;
  final Color badgeColor;
  final String imageUrl;
  final bool isCompleted;

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
          SizedBox(
            width: size,
            height: size,
            child: Stack(
              children: [
                Container(
                  width: size,
                  height: size,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isCompleted
                        ? const Color(0xFF1DB1F4)
                        : const Color(0xFFE4E5E5),
                  ),
                ),
                Center(
                  child: Container(
                    width: size - 20,
                    height: size - 20,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Container(
                        margin: const EdgeInsets.all(10),
                        padding: const EdgeInsets.all(10),
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
          const SizedBox(height: 10),
          Text(title, style: Theme.of(context).textTheme.caption),
        ],
      ),
    );
  }
}
