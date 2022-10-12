import 'package:sign_language_learning/models/question.dart';

abstract class BaseQuiz {
  Future<List<Question>> getQuestions({required String level});
}
