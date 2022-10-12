import 'package:equatable/equatable.dart';

class Question extends Equatable {
  final String question;
  final String correctAnswer;
  final List<String> answers;

  const Question({
    required this.question,
    required this.correctAnswer,
    required this.answers,
  });

  @override
  List<Object?> get props => [question, correctAnswer, answers];

  factory Question.fromMap(Map<String, dynamic> map) {
    return Question(
      question: map['question'],
      correctAnswer: map['correct_answer'],
      answers: List<String>.from(map['incorrect_answers'])
        ..add(map['correct_answer'])
        ..shuffle(),
    );
  }
}
