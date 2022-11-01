import 'package:sign_language_learning/models/badge.dart';

abstract class BaseTree {
  Future<List<Badge>> getBadges();
}
