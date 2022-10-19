import 'package:equatable/equatable.dart';

enum QuizStatus { initial, correct, incorrect, complete }

class QuizState extends Equatable {
  final String selectedAnswer;
  final QuizStatus status;
  final int questionCounter;
  final int? recognitionResult;
  //TODO: Agregar historial de respuestas
  //TODO: Agregar retroalimentación de error de API

  bool get answered =>
      status == QuizStatus.incorrect || status == QuizStatus.correct;

  const QuizState({
    required this.selectedAnswer,
    required this.status,
    required this.questionCounter,
    required this.recognitionResult,
  });

  factory QuizState.initial() {
    return const QuizState(
      selectedAnswer: '',
      status: QuizStatus.initial,
      questionCounter: 0,
      recognitionResult: null,
    );
  }

  @override
  List<Object?> get props => [selectedAnswer, status, questionCounter];

  QuizState copyWith({
    String? selectedAnswer,
    QuizStatus? status,
    int? questionCounter,
    int? recognitionResult,
  }) {
    return QuizState(
      selectedAnswer: selectedAnswer ?? this.selectedAnswer,
      status: status ?? this.status,
      questionCounter: questionCounter ?? this.questionCounter,
      recognitionResult: recognitionResult,
    );
  }
}
