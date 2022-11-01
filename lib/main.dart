import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sign_language_learning/helpers/dependency_injection.dart';
import 'package:sign_language_learning/pages/completition_page.dart';
import 'package:sign_language_learning/pages/home_page.dart';
import 'package:sign_language_learning/pages/level_page.dart';
import 'package:sign_language_learning/pages/login_page.dart';
import 'package:sign_language_learning/pages/quiz_page.dart';
import 'package:sign_language_learning/pages/register_page.dart';
import 'package:sign_language_learning/pages/welcome_page.dart';

//TODO: Create app state with riverpod and use riverpod messages to show API responses
//Consider wrapping entire widget in MessageSnackbarListener

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  DependencyInjection.initialize();

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: const SplashPage(),
      home: const LoginPage(),
      routes: {
        LoginPage.routeName: ((context) => const LoginPage()),
        RegisterPage.routeName: ((context) => const RegisterPage()),
        HomePage.routeName: ((context) => const HomePage()),
        WelcomePage.routeName: ((context) => const WelcomePage()),
        CompletitionPage.routeName: ((context) => const CompletitionPage()),
        LevelPage.routeName: ((context) => const LevelPage()),
        QuizPage.routeName: ((context) => const QuizPage()),
      },
    );
  }
}
