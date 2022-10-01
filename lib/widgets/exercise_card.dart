import 'package:expandable_bottom_bar/expandable_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sign_language_learning/api/resources_api.dart';
import 'package:sign_language_learning/providers.dart';
import 'package:sign_language_learning/widgets/card_item.dart';
import 'package:sign_language_learning/widgets/video_card.dart';

class ExerciseCard extends ConsumerWidget {
  ExerciseCard({Key? key, required this.title, required this.videoUrl})
      : super(key: key);
  final String title;
  final String videoUrl;
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
              Text("87%", style: Theme.of(context).textTheme.headline5),
            ],
          ),
          Column(
            children: [
              TextButton(
                onPressed: null,
                child: Text("No puedo activar mi cámara ahora"),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                ),
                onPressed: () async {
                  final image =
                      await ImagePicker().pickImage(source: ImageSource.camera);
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

                  final response =
                      await _accountApi.updateAvatar(bytes, "Lunes");
                  if (response.data != null) {
                    print(response.data);
                  }

                  Navigator.of(context).pop();
                },
                child: Text("Activar cámara"),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                ),
                onPressed: () {
                  ref
                      .read(newPageProvider.notifier)
                      .update((state) => state + 1);
                },
                child: Text("CONTINUAR"),
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
