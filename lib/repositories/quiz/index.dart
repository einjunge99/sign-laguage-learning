import 'package:sign_language_learning/api/resources_api.dart';
import 'package:sign_language_learning/models/question.dart';
import 'package:sign_language_learning/repositories/quiz/base.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:get_it/get_it.dart';

final quizProvider = Provider<Quiz>((ref) => Quiz());

class Quiz extends BaseQuiz {
  final _resources = GetIt.instance<ResourcesApi>();

  @override
  Future<List<Question>> getExercices({required String lectureId}) async {
    final response = await _resources.getExercices(lectureId);

    final exercices = List<Map<String, dynamic>>.from(response.data);

    return exercices.map((e) => Question.fromMap(e)).toList();
  }

  @override
  saveQuiz({required String lectureId}) async {
    await _resources.updateLectureStatus(lectureId);
  }
}
