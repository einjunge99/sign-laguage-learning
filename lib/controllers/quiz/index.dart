import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sign_language_learning/common/enums/question_type.dart';
import 'package:sign_language_learning/controllers/quiz/state.dart';
import 'package:sign_language_learning/models/question.dart';

final quizControllerProvider =
    StateNotifierProvider.autoDispose<QuizController, QuizState>(
        (ref) => QuizController());

class QuizController extends StateNotifier<QuizState> {
  QuizController() : super(QuizState.initial());

  void submitAnswer(Question currentQuestion, String answer) {
    if (state.answered) return;
    var isCorrect = answer == currentQuestion.answer;
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

  int? nextQuestion(List<Question> questions, int currentIndex, bool skipped) {
    final shouldContinueQuiz = currentIndex + 1 < questions.length;
    var status = shouldContinueQuiz ? QuizStatus.initial : QuizStatus.complete;

    var questionCounter =
        shouldContinueQuiz ? state.questionCounter + 1 : state.questionCounter;

    var jumpToIndex = shouldContinueQuiz ? currentIndex + 1 : null;

    if (shouldContinueQuiz && (skipped || state.shouldSkipRecognition)) {
      int nextIndex = questions.indexWhere(
          (element) => element.type != QuestionType.recognition,
          currentIndex + 1);

      if (nextIndex != -1) {
        jumpToIndex = nextIndex;
      } else {
        status = QuizStatus.complete;
      }
    }

    state = state.copyWith(
      selectedAnswer: '',
      recognitionResult: null,
      status: status,
      questionCounter: questionCounter,
      shouldSkipRecognition:
          state.shouldSkipRecognition ? state.shouldSkipRecognition : skipped,
    );

    return jumpToIndex;
  }

  void reset() {
    state = QuizState.initial();
  }
}
