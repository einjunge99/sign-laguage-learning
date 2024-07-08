import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sign_language_learning/controllers/index.dart';
import 'package:sign_language_learning/pages/quiz_page.dart';

final tooltipVisibilityProvider = StateProvider<bool>((ref) => false);

class CircularBadge extends ConsumerWidget {
  const CircularBadge({
    Key? key,
    required this.uid,
    required this.title,
    required this.badgeColor,
    required this.iconUrl,
    required this.isCompleted,
    required this.isUnlocked,
  }) : super(key: key);

  final String uid;
  final String title;
  final Color badgeColor;
  final String iconUrl;
  final bool isCompleted;
  final bool isUnlocked;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const size = 125.0;
    return GestureDetector(
      onTap: () {
        if (!isUnlocked) {
          return;
        }
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
                        foregroundDecoration: !isUnlocked
                            ? const BoxDecoration(
                                color: Colors.grey,
                                backgroundBlendMode: BlendMode.saturation,
                              )
                            : null,
                        decoration: const BoxDecoration(
                          color: Color(0xFFE4E5E5),
                          shape: BoxShape.circle,
                        ),
                        child: ClipOval(
                          child: Image.network(
                            iconUrl,
                            fit: BoxFit.cover,
                            loadingBuilder: (BuildContext context, Widget child,
                                ImageChunkEvent? loadingProgress) {
                              if (loadingProgress == null) {
                                return child;
                              }
                              return Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                      : null,
                                ),
                              );
                            },
                          ),
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
