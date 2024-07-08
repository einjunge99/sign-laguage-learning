import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sign_language_learning/api/resources_api.dart';
import 'package:sign_language_learning/controllers/index.dart';
import 'package:sign_language_learning/controllers/quiz/index.dart';
import 'package:sign_language_learning/controllers/quiz/state.dart';
import 'package:sign_language_learning/models/question.dart';
import 'package:sign_language_learning/ui/decoration.dart';
import 'package:sign_language_learning/widgets/common/button.dart';
import 'package:sign_language_learning/widgets/video_card.dart';

class ExerciseCard extends HookConsumerWidget {
  ExerciseCard(
      {Key? key,
      required this.title,
      required this.label,
      required this.pageController,
      required this.questions,
      required this.videoId})
      : super(key: key);

  final PageController pageController;
  final String title;
  final String label;
  final String videoId;
  final List<Question> questions;
  final _accountApi = GetIt.instance<ResourcesApi>();

  void _onButtonPressed(context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return FractionallySizedBox(
          heightFactor: 0.3,
          child: Container(
            color: const Color(0xFF737373),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: Theme.of(context).canvasColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //TODO: Add pulsating effect
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 100),
                      child: Container(
                        color: Colors.black,
                        height: 6,
                      ),
                    ),
                    VideoCard(videoUrl: videoId),
                  ]),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      margin: const EdgeInsets.only(bottom: buttonHeight),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Practica tus habilidades',
                style: Theme.of(context).textTheme.headline6,
              ),
              Text(
                'Usa la cámara para hacer la seña indicada',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: 300,
                    child: Text(
                      title,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: Theme.of(context).textTheme.headline3,
                    ),
                  ),
                  Material(
                    type: MaterialType.transparency,
                    child: Ink(
                      decoration: BoxDecoration(
                        border: Border.all(color: primary, width: 4),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: InkWell(
                        onTap: () => _onButtonPressed(context),
                        child: const Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Icon(
                            Icons.lightbulb_outline,
                            size: 35.0,
                            color: primary,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Visibility(
                visible:
                    ref.watch(quizControllerProvider).recognitionResult != null,
                child: Text(
                  "${ref.watch(quizControllerProvider).recognitionResult}%",
                  style: Theme.of(context).textTheme.headline5?.copyWith(
                        color: ref.watch(quizControllerProvider).status ==
                                QuizStatus.incorrect
                            ? Colors.red
                            : primary,
                      ),
                ),
              ),
            ],
          ),
          Column(
            children: [
              TextButton(
                onPressed: ref.watch(quizControllerProvider).status ==
                        QuizStatus.correct
                    ? null
                    : () {
                        final questionIndex = ref
                            .read(quizControllerProvider.notifier)
                            .nextQuestion(
                              questions,
                              pageController.page?.toInt() ?? 0,
                              true,
                            );
                        if (questionIndex == null) {
                          pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeIn,
                          );
                        } else {
                          pageController.jumpToPage(questionIndex);
                        }
                      },
                child: const Text(
                  "NO PUEDO USAR MI CÁMARA AHORA",
                  //TODO: Isolate TextButton styles
                  style: TextStyle(
                    color: primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              CustomButton(
                variant: ButtonVariant.secondary,
                onTap: ref.watch(quizControllerProvider).status ==
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
                            return const Center(
                              child: CircularProgressIndicator(color: primary),
                            );
                          },
                        );

                        final bytes = await image.readAsBytes();

                        final _selectedLecture =
                            ref.read(lectureController.notifier).state;

                        final response = await _accountApi.predict(
                            bytes, label, _selectedLecture);
                        if (response.data != null) {
                          if (response.data["error"] == null) {
                            ref
                                .read(quizControllerProvider.notifier)
                                .setRecognitionResult(response.data);
                          }
                        }

                        Navigator.of(context).pop();
                      },
                title: ref.watch(quizControllerProvider).status ==
                        QuizStatus.incorrect
                    ? "INTENTAR DE NUEVO"
                    : "ACTIVAR CÁMARA",
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
