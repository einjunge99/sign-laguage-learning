import 'package:flutter/material.dart';
import 'package:sign_language_learning/models/badge.dart';
import 'package:sign_language_learning/widgets/circular_badge.dart';

class BadgeContainer extends StatelessWidget {
  const BadgeContainer({Key? key, required this.content}) : super(key: key);

  final dynamic content;

  @override
  Widget build(BuildContext context) {
    if (content is Badge) {
      return CircularBadge(
        uid: content.uid,
        title: content.title,
        badgeColor: content.badgeColor,
        imageUrl: content.imageUrl,
        isCompleted: content.isCompleted,
      );
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: (content as List<Badge>)
          .map(
            (badge) => CircularBadge(
              uid: badge.uid,
              title: badge.title,
              badgeColor: badge.badgeColor,
              imageUrl: badge.imageUrl,
              isCompleted: badge.isCompleted,
            ),
          )
          .toList(),
    );
  }
}
