import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sign_language_learning/pages/completition_page.dart';
import 'package:sign_language_learning/pages/home_page.dart';
import 'package:sign_language_learning/providers.dart';
import 'package:sign_language_learning/ui/decoration.dart';
import 'package:sign_language_learning/widgets/common/dialogs.dart';
import 'package:sign_language_learning/widgets/exercise_card.dart';
import 'package:sign_language_learning/widgets/progress_bar.dart';

const kDefaultPadding = 1.0;

class Exercise {
  final String lessonUid;
  final String title;
  final String videoUrl;

  Exercise(this.lessonUid, this.title, this.videoUrl);
}

class LevelPageArguments {
  final String uid;
  LevelPageArguments(this.uid);
}

class LevelPage extends ConsumerStatefulWidget {
  const LevelPage({Key? key}) : super(key: key);
  static const String routeName = "level_page";
  @override
  _LevelPageState createState() => _LevelPageState();
}

//TODO: reset level state on init
class _LevelPageState extends ConsumerState<LevelPage> {
  List<Exercise> exercices = [
    Exercise(
      "001",
      "Lunes",
      "E080c6FJW9U",
    ),
    Exercise(
      "001",
      "Martes",
      "GfNcVJVWE9k",
    ),
    Exercise(
      "001",
      "Miércoles",
      "wWagjkpNuo8",
    ),
    Exercise(
      "001",
      "Viernes",
      "wWagjkpNuo8",
    ),
    Exercise(
      "001",
      "Sábado",
      "wWagjkpNuo8",
    ),
    Exercise(
      "001",
      "Domingo",
      "wWagjkpNuo8",
    ),
    Exercise(
      "002",
      "Enero",
      "Zh577vcSras",
    ),
    Exercise(
      "002",
      "Mayo",
      "LY-m7asBi7Q",
    ),
    Exercise(
      "002",
      "Noviembre",
      "OV3gVrq0rXk",
    ),
    Exercise(
      "003",
      "Gracias",
      "RI8hf9rIcoI",
    ),
    Exercise(
      "003",
      "Permiso",
      "7O2xzU-76zQ",
    ),
    Exercise(
      "003",
      "C",
      "XNvati9JlfE",
    ),
  ];
  List<Exercise> items = [];
  final pageController = PageController(
    initialPage: 0,
  );

  Future<bool> _onWillPop() async {
    return (Dialogs.alert(
          context,
          title: "Alto!",
          description: "Estás seguro que quieres salir?",
        )) ??
        false;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      final args =
          ModalRoute.of(context)!.settings.arguments as LevelPageArguments;

      final result =
          exercices.where((element) => element.lessonUid == args.uid).toList();

      setState(() {
        items = result;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<int>(newPageProvider, (int? previousIndex, int newIndex) {
      _gotoPage(newIndex, items.length);
    });
    if (items.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(color: primary),
      );
    }

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: Stack(
          children: [
            SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                    child: ProgressBar(
                      totalPages: items.length,
                    ),
                  ),
                  // Expanded(
                  //   child: PageView.builder(
                  //     physics: const NeverScrollableScrollPhysics(),
                  //     controller: pageController,
                  //     // onPageChanged: _questionController.updateTheQnNum,
                  //     itemCount: items.length,
                  //     itemBuilder: (context, index) => ExerciseCard(
                  //       title: items[index].title,
                  //       videoUrl: items[index].videoUrl,
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _gotoPage(int index, int availablePages) {
    if (index == availablePages) {
      //TODO: redirect to congratulations page
      Navigator.pushNamedAndRemoveUntil(
        context,
        CompletitionPage.routeName,
        (_) => false,
      );
    } else {
      pageController.animateToPage(
        index,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeIn,
      );
    }
  }
}
