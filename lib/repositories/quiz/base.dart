import 'package:sign_language_learning/models/question.dart';

abstract class BaseQuiz {
  Future<List<Question>> getExercices({required String lectureId});
  saveQuiz({required String lectureId});
}
