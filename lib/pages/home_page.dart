import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sign_language_learning/models/badge.dart';
import 'package:sign_language_learning/models/user.dart';
import 'package:sign_language_learning/providers.dart';
import 'package:sign_language_learning/repositories/profile/index.dart';
import 'package:sign_language_learning/repositories/tree/index.dart';
import 'package:sign_language_learning/ui/decoration.dart';
import 'package:sign_language_learning/widgets/badge_container.dart';
import 'package:sign_language_learning/widgets/common/button.dart';
import 'package:sign_language_learning/widgets/common/header.dart';
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
          icon: const Icon(Icons.apps),
          title: const Text('INICIO'),
          activeColor: Colors.green,
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
        BottomNavyBarItem(
          icon: const Icon(Icons.person),
          title: const Text('PERFIL'),
          activeColor: primary,
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final treeBadges = ref.watch(treeBadgesProvider);

    return SafeArea(
      child: Scaffold(
        body: treeBadges.when(
          data: (badges) => getBody(badges),
          error: (error, _) => Center(child: Text(error.toString())),
          loading: () => const Center(
            child: CircularProgressIndicator(color: primary),
          ),
        ),
        bottomNavigationBar: _buildBottomBar(),
      ),
    );
  }
}

final userInfoProvider = FutureProvider.autoDispose<LocalUser>((ref) {
  return ref.watch(profileProvider).getUserInfo();
});

class Profile extends ConsumerStatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends ConsumerState<Profile> {
  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(authenticationClientStateProvider.notifier);
    final userInfo = ref.watch(userInfoProvider);

    return userInfo.when(
      data: (user) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Header(title: 'Datos del usuario'),
            Expanded(
              flex: 10,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Text(
                          user.displayName ?? "",
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        Text(
                          user.email,
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ],
                    ),
                    const Divider(height: 50),
                    CustomButton(
                      title: 'CERRAR SESIÓN',
                      onTap: () async {
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
                  ],
                ),
              ),
            ),
          ],
        );
      },
      error: (err, s) => Text(err.toString()),
      loading: () => const Center(
        child: CircularProgressIndicator(color: primary),
      ),
    );
  }
}

class LearningTree extends ConsumerWidget {
  const LearningTree({
    Key? key,
    required this.badges,
  }) : super(key: key);

  final List<Badge> badges;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Header(title: "Árbol de aprendizaje"),
        Expanded(
          flex: 10,
          child: ListView.builder(
            itemCount: badges.length,
            itemBuilder: (context, index) {
              final item = badges[index];
              bool isUnlocked = false;
              if ((badges.length == 1 || index == 0) || item.isCompleted) {
                isUnlocked = true;
              } else if (index != 0 && badges[index - 1].isCompleted) {
                isUnlocked = true;
              }

              return BadgeContainer(
                content: item,
                isUnlocked: isUnlocked,
                alignment: index % 2 == 0
                    ? Alignment.centerLeft
                    : Alignment.centerRight,
              );
            },
          ),
        ),
      ],
    );
  }
}
