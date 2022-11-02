import 'package:flutter/material.dart';
import 'package:sign_language_learning/models/badge.dart';
import 'package:sign_language_learning/widgets/circular_badge.dart';

class BadgeContainer extends StatelessWidget {
  const BadgeContainer({Key? key, required this.content}) : super(key: key);

  final Badge content;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: CircularBadge(
        uid: content.uid,
        title: content.title,
        badgeColor: content.badgeColor,
        imageUrl: content.imageUrl,
        isCompleted: content.isCompleted,
      ),
    );
  }
}
