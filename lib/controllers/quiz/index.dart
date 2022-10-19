import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sign_language_learning/controllers/quiz/state.dart';
import 'package:sign_language_learning/models/question.dart';

//TODO: Agregar tipado a Notifier
final quizControllerProvider =
    StateNotifierProvider.autoDispose<QuizController, QuizState>(
        (ref) => QuizController());

class QuizController extends StateNotifier<QuizState> {
  QuizController() : super(QuizState.initial());

  void submitAnswer(Question currentQuestion, String answer) {
    if (state.answered) return;
    var isCorrect = answer == currentQuestion.correctAnswer;
    state = state.copyWith(
      selectedAnswer: answer,
      status: isCorrect ? QuizStatus.correct : QuizStatus.incorrect,
      correctAnswers:
          isCorrect ? state.correctAnswers + 1 : state.correctAnswers,
    );
  }

  void setRecognitionResult(dynamic data) {
    var confidence = (data["confidence"] as double).round();
    var isCorrect = data["correct"] as bool;

    state = state.copyWith(
      recognitionResult: confidence,
      status: isCorrect ? QuizStatus.correct : QuizStatus.incorrect,
      correctAnswers: state.correctAnswers + (isCorrect ? 1 : 0),
    );
  }

  void nextQuestion(List<Question> questions, int currentIndex) {
    state = state.copyWith(
      selectedAnswer: '',
      recognitionResult: null,
      status: currentIndex + 1 < questions.length
          ? QuizStatus.initial
          : QuizStatus.complete,
      questionCounter: currentIndex + 1 < questions.length
          ? state.questionCounter + 1
          : state.questionCounter,
    );
  }

  void reset() {
    state = QuizState.initial();
  }
}
