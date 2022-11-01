import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sign_language_learning/models/badge.dart';
import 'package:sign_language_learning/models/user.dart';
import 'package:sign_language_learning/pages/quiz_page.dart';
import 'package:sign_language_learning/providers.dart';
import 'package:sign_language_learning/repositories/tree/index.dart';
import 'package:sign_language_learning/widgets/badge_container.dart';
import 'package:sign_language_learning/widgets/common/input_text.dart';
import 'package:sign_language_learning/widgets/custom_animated_bottom_bar.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static const String routeName = "home_page";

  @override
  _HomePageState createState() => _HomePageState();
}

final treeBadgesProvider = FutureProvider.autoDispose<List<Badge>>((ref) {
  return ref.watch(treeProvider).getBadges();
});

class _HomePageState extends ConsumerState<HomePage> {
  int _currentIndex = 0;
  final _inactiveColor = Colors.grey;

  Widget getBody(badges) {
    List<Widget> pages = [
      LearningTree(badges: badges),
      const Profile(),
    ];
    return IndexedStack(
      index: _currentIndex,
      children: pages,
    );
  }

  Widget _buildBottomBar() {
    return CustomAnimatedBottomBar(
      containerHeight: 70,
      backgroundColor: Colors.white,
      selectedIndex: _currentIndex,
      showElevation: true,
      itemCornerRadius: 24,
      curve: Curves.easeIn,
      onItemSelected: (index) => setState(() => _currentIndex = index),
      items: <BottomNavyBarItem>[
        BottomNavyBarItem(
          icon: Icon(Icons.apps),
          title: Text('INICIO'),
          activeColor: Colors.green,
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
        BottomNavyBarItem(
          icon: Icon(Icons.people),
          title: Text('PERFIL'),
          activeColor: Color(0xFF1DB1F4),
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final treeBadges = ref.watch(treeBadgesProvider);

    return Scaffold(
      body: treeBadges.when(
        data: (badges) => getBody(badges),
        error: (error, _) => Center(child: Text(error.toString())),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
      bottomNavigationBar: _buildBottomBar(),
    );
  }
}

class Profile extends ConsumerStatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends ConsumerState<Profile> {
  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(authenticationClientStateProvider.notifier);
    final _data = ref.watch(userDataProvider);

    return Container(
      padding: EdgeInsets.all(20),
      child: _data.when(
        data: (snapshot) {
          final map = snapshot.data();
          LocalUser user = LocalUser.fromMap(map);
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Perfil",
                style: TextStyle(fontSize: 30),
              ),
              InputText(
                initialValue: user.email,
                label: "Email",
              ),
              InputText(
                initialValue: user.displayName,
                label: "Nombre",
              ),
              Center(
                child: ElevatedButton(
                  child: Text('Cerrar sesión'),
                  onPressed: () async {
                    String? response = await notifier.logout();
                    if (response != null) {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        response,
                        (_) => false,
                      );
                    }
                  },
                ),
              ),
            ],
          );
        },
        error: (err, s) => Text(err.toString()),
        loading: () => Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}

class LearningTree extends ConsumerWidget {
  const LearningTree({
    Key? key,
    required this.badges,
  }) : super(key: key);

  final List badges;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: badges.length,
            itemBuilder: (context, index) {
              final item = badges[index];

              return BadgeContainer(
                content: item,
              );
            },
          ),
        ),
        Expanded(
          child: Column(
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    QuizPage.routeName,
                  );
                },
                child: Text("Ejercicio de prueba..."),
              ),
              Text(
                "Más lecciones disponibles próximanente...",
                textAlign: TextAlign.center,
              ),
            ],
          ),
        )
      ],
    );
  }
}
