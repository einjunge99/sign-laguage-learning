import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sign_language_learning/api/resources_api.dart';
import 'package:sign_language_learning/controllers/quiz/index.dart';
import 'package:sign_language_learning/controllers/quiz/state.dart';
import 'package:sign_language_learning/models/question.dart';
import 'package:sign_language_learning/providers.dart';

//TODO: Increase counter when user skips a question
class ExerciseCard extends HookConsumerWidget {
  ExerciseCard({
    Key? key,
    required this.title,
    required this.videoID,
    required this.pageController,
    required this.questions,
  }) : super(key: key);

  final PageController pageController;
  final String title;
  final String videoID;
  final List<Question> questions;
  //TODO: Add exercise key
  final _accountApi = GetIt.instance<ResourcesApi>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            children: [
              Text(title, style: Theme.of(context).textTheme.headline2),
              Visibility(
                visible:
                    ref.watch(quizControllerProvider).recognitionResult != null,
                child: Text(
                  "${ref.watch(quizControllerProvider).recognitionResult}%",
                  style: Theme.of(context).textTheme.headline5?.copyWith(
                        color: ref.watch(quizControllerProvider).status ==
                                QuizStatus.incorrect
                            ? Colors.red
                            : Colors.green,
                      ),
                ),
              ),
            ],
          ),
          Column(
            children: [
              TextButton(
                onPressed: ref
                            .watch(quizControllerProvider)
                            .recognitionResult ==
                        QuizStatus.correct
                    ? null
                    : () {
                        ref.read(quizControllerProvider.notifier).nextQuestion(
                              questions,
                              pageController.page?.toInt() ?? 0,
                            );
                        pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeIn,
                        );
                      },
                child: Text("No puedo activar mi cámara ahora"),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                ),
                onPressed: ref.watch(quizControllerProvider).status ==
                        QuizStatus.correct
                    ? null
                    : () async {
                        final image = await ImagePicker()
                            .pickImage(source: ImageSource.camera);
                        if (image == null) {
                          return;
                        }

                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          },
                        );

                        final bytes = await image.readAsBytes();

                        //TODO: Replace title with exercise key
                        final response =
                            await _accountApi.updateAvatar(bytes, title);
                        if (response.data != null) {
                          if (response.data["error"] == null) {
                            ref
                                .read(quizControllerProvider.notifier)
                                .setRecognitionResult(response.data);
                          }
                        }

                        Navigator.of(context).pop();
                      },
                child: Text(ref.watch(quizControllerProvider).status ==
                        QuizStatus.incorrect
                    ? "INTENTAR DE NUEVO"
                    : "ACTIVAR CÁMARA"),
              ),
            ]
                .map((e) => Padding(
                      child: e,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}

class CircularButton extends StatelessWidget {
  const CircularButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
