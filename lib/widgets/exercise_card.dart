import 'package:expandable_bottom_bar/expandable_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sign_language_learning/providers.dart';
import 'package:sign_language_learning/widgets/card_item.dart';
import 'package:sign_language_learning/widgets/video_card.dart';

class ExerciseCard extends ConsumerWidget {
  ExerciseCard({Key? key, required this.title, required this.videoUrl})
      : super(key: key);
  final String title;
  final String videoUrl;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(title, style: Theme.of(context).textTheme.headline6),
              Container(
                padding: EdgeInsets.all(40),
                child: VideoCard(
                  videoUrl: videoUrl,
                ),
              ),
              TileItem(
                tag: "test",
                child: Center(
                  child: Text("Hello from hero"),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  ref
                      .read(newPageProvider.notifier)
                      .update((state) => state + 1);
                },
                child: Text("CONTINUAR"),
              ),
            ],
          ),
        ),
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
