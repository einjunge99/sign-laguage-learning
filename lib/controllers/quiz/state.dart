import 'package:equatable/equatable.dart';

enum QuizStatus { initial, correct, incorrect, complete }

class QuizState extends Equatable {
  final String selectedAnswer;
  final QuizStatus status;
  final int questionCounter;
  final int? recognitionResult;
  final int skipedQuestions;
  final int correctAnswers;

  //TODO: Agregar historial de respuestas
  //TODO: Agregar retroalimentación de error de API

  bool get answered =>
      status == QuizStatus.incorrect || status == QuizStatus.correct;

  int get overview =>
      (correctAnswers / (questionCounter - skipedQuestions) * 100).round();

  const QuizState({
    required this.selectedAnswer,
    required this.status,
    required this.questionCounter,
    required this.recognitionResult,
    required this.skipedQuestions,
    required this.correctAnswers,
  });

  factory QuizState.initial() {
    return const QuizState(
      selectedAnswer: '',
      status: QuizStatus.initial,
      questionCounter: 0,
      recognitionResult: null,
      skipedQuestions: 0,
      correctAnswers: 0,
    );
  }

  @override
  List<Object?> get props => [selectedAnswer, status, questionCounter];

  QuizState copyWith({
    String? selectedAnswer,
    QuizStatus? status,
    int? questionCounter,
    int? recognitionResult,
    int? skipedQuestions,
    int? correctAnswers,
  }) {
    return QuizState(
      selectedAnswer: selectedAnswer ?? this.selectedAnswer,
      status: status ?? this.status,
      questionCounter: questionCounter ?? this.questionCounter,
      recognitionResult: recognitionResult,
      skipedQuestions: skipedQuestions ?? this.skipedQuestions,
      correctAnswers: correctAnswers ?? this.correctAnswers,
    );
  }
}
