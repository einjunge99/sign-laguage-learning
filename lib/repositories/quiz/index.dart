import 'package:sign_language_learning/models/question.dart';
import 'package:sign_language_learning/repositories/quiz/base.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'dart:convert';

const data =
    '{"response_code": 0,"results": [{"question": "Lunes","correct_answer": "Lunes","incorrect_answers": ["Martes", "Miércoles", "Jueves"]}, {"question": "Martes","correct_answer": "Martes","incorrect_answers": ["Miércoles", "Jueves","Sábado"]}, {"question": "Miércoles","correct_answer": "Miércoles","incorrect_answers": ["Lunes", "Viernes","Domingo"]}, {"question": "Jueves","correct_answer": "Jueves","incorrect_answers": ["Lunes","Miércoles","Sábado"]}, {"question": "Viernes","correct_answer": "Viernes","incorrect_answers": ["Lunes","Miércoles","Sábado"]}, {"question": "Sábado","correct_answer": "Sábado","incorrect_answers": ["Martes","Miércoles", "Jueves"]}, {"question": "Domingo","correct_answer": "Domingo","incorrect_answers": ["Lunes","Miércoles", "Viernes"]}]}';

final quizProvider = Provider<Quiz>((ref) => Quiz());

class Quiz extends BaseQuiz {
  @override
  Future<List<Question>> getQuestions({required String level}) async {
    //TODO: Replace with api util
    Map valueMap = json.decode(data);
    final results = List<Map<String, dynamic>>.from(valueMap['results']);

    try {
      final parsed = results.map((e) => Question.fromMap(e)).toList();
      return parsed;
    } catch (e) {
      print(e);
      return [];
    }
  }
}
