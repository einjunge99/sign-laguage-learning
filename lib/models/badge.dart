import 'package:flutter/material.dart';

//TODO: Renderizar todo el arbol con base a lo configurado en Firestore
// https://www.raywenderlich.com/26435435-firestore-tutorial-for-flutter-getting-started
class Badge {
  final String uid;
  final String title;
  final Color badgeColor;
  final String imageUrl;
  final bool isCompleted;

  Badge({
    required this.uid,
    required this.title,
    required this.badgeColor,
    required this.imageUrl,
    required this.isCompleted,
  });

  static Color getColorFromVariant(String variant) {
    switch (variant) {
      case "A":
        return const Color(0xFF1DB1F4);
      default:
        return const Color(0xFF1DB1F4);
    }
  }

  factory Badge.fromMap(Map<String, dynamic> map) {
    return Badge(
      uid: map['id'] as String,
      title: map['title'] as String,
      badgeColor: getColorFromVariant(map['variant'] ?? 'UNKNOWN'),
      imageUrl: map['imageUrl'] as String,
      isCompleted: map['isCompleted'] as bool,
    );
  }
}
