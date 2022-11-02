import 'package:sign_language_learning/models/user.dart';

abstract class BaseProfile {
  Future<LocalUser> getUserInfo();
}
