import 'package:equatable/equatable.dart';
import 'package:sign_language_learning/common/enums/question_type.dart';

class Question extends Equatable {
  final String question;
  final QuestionType type;
  final String key;
  final String? correctAnswer;
  final List<String>? answers;

  const Question({
    required this.question,
    required this.correctAnswer,
    required this.answers,
    required this.type,
    required this.key,
  });

  @override
  List<Object?> get props => [question, correctAnswer, answers, type, key];

  factory Question.fromMap(Map<String, dynamic> map) {
    return Question(
      question: map['question'] ?? '',
      correctAnswer: map['correct_answer'] ?? '',
      answers: map['incorrect_answers'] == null
          ? []
          : (List<String>.from(map['incorrect_answers'])
            ..add(map['correct_answer'])
            ..shuffle()),
      type: map['type'].toString().type,
      key: map['key'],
    );
  }
}
