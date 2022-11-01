import 'package:flutter/material.dart';

//TODO: Renderizar todo el arbol con base a lo configurado en Firestore
// https://www.raywenderlich.com/26435435-firestore-tutorial-for-flutter-getting-started
class Badge {
  final String uid;
  final String title;
  final Color badgeColor;
  final String imageUrl;
  String? referenceUid;

  Badge({
    required this.uid,
    required this.title,
    required this.badgeColor,
    required this.imageUrl,
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
      uid: map['uid'] as String,
      title: map['title'] as String,
      badgeColor: getColorFromVariant(map['variant'] as String),
      imageUrl: map['imageUrl'] as String,
    );
  }
}
