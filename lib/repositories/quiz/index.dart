import 'package:sign_language_learning/models/question.dart';
import 'package:sign_language_learning/repositories/quiz/base.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'dart:convert';

//TODO: Add keys from corresponding video ID
const data = '''
{
	"response_code": 0,
	"results": [
  {
    "type": "multiple",
    "key": "1",
		"question": "Lunes",
		"correct_answer": "Lunes",
		"incorrect_answers": ["Martes", "Miércoles", "Jueves"]
	}, {
    "type": "multiple",
    "key": "2",
		"question": "Martes",
		"correct_answer": "Martes",
		"incorrect_answers": ["Miércoles", "Jueves", "Sábado"]
	}, {
    "type": "multiple",
    "key": "3",
		"question": "Miércoles",
		"correct_answer": "Miércoles",
		"incorrect_answers": ["Lunes", "Viernes", "Domingo"]
	}, {
    "type": "multiple",
    "key": "4",
		"question": "Jueves",
		"correct_answer": "Jueves",
		"incorrect_answers": ["Lunes", "Miércoles", "Sábado"]
	}, {
    "type": "multiple",
    "key": "5",
		"question": "Viernes",
		"correct_answer": "Viernes",
		"incorrect_answers": ["Lunes", "Miércoles", "Sábado"]
	}, {
    "type": "multiple",
    "key": "6",
		"question": "Sábado",
		"correct_answer": "Sábado",
		"incorrect_answers": ["Martes", "Miércoles", "Jueves"]
	}, {
    "type": "multiple",
    "key": "7",
		"question": "Domingo",
		"correct_answer": "Domingo",
		"incorrect_answers": ["Lunes", "Miércoles", "Viernes"]
	}, {
    "type": "recognition",
    "question": "Lunes",
    "key": "lunes"
  }, {
    "type": "recognition",
    "question": "Martes",
    "key": "martes"
  }, {
    "type": "recognition",
    "question": "Miércoles",
    "key": "miercoles"
  }, {
    "type": "recognition",
    "question": "Jueves",
    "key": "jueves"
  }, {
    "type": "recognition",
    "question": "Viernes",
    "key": "viernes"
  }, {
    "type": "recognition",
    "question": "Sábado",
    "key": "sabado"
  }, {
    "type": "recognition",
    "question": "Domingo",
    "key": "domingo"
  }
  ]
}
''';

final quizProvider = Provider<Quiz>((ref) => Quiz());

//TODO: Limit and randomize questions from server
class Quiz extends BaseQuiz {
  @override
  Future<List<Question>> getQuestions({required String level}) async {
    //TODO: Replace with api util
    Map valueMap = json.decode(data);
    final results = List<Map<String, dynamic>>.from(valueMap['results']);

    try {
      return results.map((e) => Question.fromMap(e)).toList()..shuffle();
    } catch (e) {
      print(e);
      return [];
    }
  }
}
