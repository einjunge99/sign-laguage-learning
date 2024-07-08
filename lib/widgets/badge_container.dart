import 'package:flutter/material.dart';
import 'package:sign_language_learning/models/badge.dart';
import 'package:sign_language_learning/widgets/circular_badge.dart';

class BadgeContainer extends StatelessWidget {
  const BadgeContainer(
      {Key? key,
      required this.content,
      required this.isUnlocked,
      required this.alignment})
      : super(key: key);

  final Badge content;
  final bool isUnlocked;
  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: FractionallySizedBox(
        widthFactor: 0.8,
        child: Container(
          padding: const EdgeInsets.all(10),
          child: CircularBadge(
            uid: content.uid,
            title: content.title,
            badgeColor: content.badgeColor,
            iconUrl: content.iconUrl,
            isCompleted: content.isCompleted,
            isUnlocked: isUnlocked,
          ),
        ),
      ),
    );
  }
}
