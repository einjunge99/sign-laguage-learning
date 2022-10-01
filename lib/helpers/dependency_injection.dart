import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_language_learning/api/authentication_api.dart';
import 'package:sign_language_learning/data/authentication_client.dart';

abstract class DependencyInjection {
  static void initialize() {
    final GoogleSignIn googleSignIn = GoogleSignIn();

    final authenticationApi = AuthenticationApi(googleSignIn);
    final authenticationClient = AuthenticationClient(authenticationApi);

    GetIt.instance.registerSingleton<AuthenticationApi>(authenticationApi);
    GetIt.instance
        .registerSingleton<AuthenticationClient>(authenticationClient);
  }
}
