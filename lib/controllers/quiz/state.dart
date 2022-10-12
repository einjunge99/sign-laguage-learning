import 'package:equatable/equatable.dart';

enum QuizStatus { initial, correct, incorrect, complete }

class QuizState extends Equatable {
  final String selectedAnswer;
  final QuizStatus status;
  //TODO: Agregar historial de respuestas

  bool get answered =>
      status == QuizStatus.incorrect || status == QuizStatus.correct;

  const QuizState({
    required this.selectedAnswer,
    required this.status,
  });

  factory QuizState.initial() {
    return const QuizState(
      selectedAnswer: '',
      status: QuizStatus.initial,
    );
  }

  @override
  List<Object?> get props => [selectedAnswer, status];

  QuizState copyWith({
    String? selectedAnswer,
    QuizStatus? status,
  }) {
    return QuizState(
      selectedAnswer: selectedAnswer ?? this.selectedAnswer,
      status: status ?? this.status,
    );
  }
}
