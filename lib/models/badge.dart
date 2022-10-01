import 'package:flutter/material.dart';

//TODO: Renderizar todo el arbol con base a lo configurado en Firestore
//TODO: Al momento de renderizar cada Badge, se debe verificar si el usuario ya ha completado el badge.
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

  Color getColorFromVariant(String variant) {
    switch (variant) {
      case "A":
        return const Color(0xFF1DB1F4);
      default:
        return const Color(0xFF1DB1F4);
    }
  }

  Badge fromJson(Map<String, dynamic> json) {
    return Badge(
      uid: json['uid'] as String,
      title: json['title'] as String,
      badgeColor: getColorFromVariant(json['variant'] as String),
      imageUrl: json['imageUrl'] as String,
    );
  }
}
