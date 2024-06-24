import 'package:equatable/equatable.dart';
import 'package:sign_language_learning/common/enums/question_type.dart';

class Question extends Equatable {
  final String? key;
  final String? lectureId;
  final QuestionType type;
  final String videoId;
  final String question;
  final String? answer;
  final List<String>? options;

  const Question({
    required this.key,
    required this.lectureId,
    required this.type,
    required this.videoId,
    required this.question,
    required this.answer,
    required this.options,
  });

  @override
  List<Object?> get props => [question, answer, options, type, key];

  factory Question.fromMap(Map<String, dynamic> map) {
    return Question(
      key: map['key'],
      lectureId: map['lectureId'],
      type: map['type'].toString().type,
      videoId: map['videoId'],
      question: map['question'] ?? '',
      answer: map['answer'] ?? '',
      options: map['options'] == null ? [] : List<String>.from(map['options']),
    );
  }
}
