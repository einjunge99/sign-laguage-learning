import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_language_learning/api/authentication_api.dart';
import 'package:sign_language_learning/api/resources_api.dart';
import 'package:sign_language_learning/data/authentication_client.dart';
import 'package:sign_language_learning/helpers/http.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class DependencyInjection {
  static void initialize() {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final Dio dio = Dio(BaseOptions(
      baseUrl: (dotenv.env['API_URL'] ?? '') + '/api/v1',
    ));
    Http http = Http(dio: dio, logsEnabled: true);

    final authenticationApi = AuthenticationApi(googleSignIn);
    final authenticationClient = AuthenticationClient(authenticationApi);
    final resourcesApi = ResourcesApi(http);

    GetIt.instance.registerSingleton<AuthenticationApi>(authenticationApi);
    GetIt.instance
        .registerSingleton<AuthenticationClient>(authenticationClient);
    GetIt.instance.registerSingleton<ResourcesApi>(resourcesApi);
  }
}
