import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:sign_language_learning/data/authentication_client.dart';
import 'package:sign_language_learning/models/user.dart';

class AuthenticationClientState {
  final String? error;
  final String? info;
  final String? path;
  final bool loading;

  const AuthenticationClientState(
      {this.loading = false, this.error, this.info, this.path});

  AuthenticationClientState copyWith(
      {String? error, String? info, bool? loading}) {
    return AuthenticationClientState(
        error: error ?? this.error,
        info: info ?? this.info,
        loading: loading ?? this.loading);
  }

  AuthenticationClientState reset() {
    return const AuthenticationClientState(
      loading: true,
      error: null,
      info: null,
      path: null,
    );
  }
}

class AuthenticationClientNotifier
    extends StateNotifier<AuthenticationClientState> {
  AuthenticationClientNotifier() : super(const AuthenticationClientState());

  final _authenticationClient = GetIt.instance<AuthenticationClient>();

  Future<String?> googleSignIn() async {
    state = state.reset();

    AuthenticationClientState? response =
        await _authenticationClient.googleSignIn();

    state = state.copyWith(
      loading: false,
      error: response?.error,
      info: response?.info,
    );

    return response?.path;
  }

  Future<String?> emailAndPasswordSignIn({
    required String email,
    required String password,
  }) async {
    state = state.reset();

    AuthenticationClientState? response =
        await _authenticationClient.emailAndPasswordSignIn(
      email: email,
      password: password,
    );

    state = state.copyWith(
      loading: false,
      error: response?.error,
      info: response?.info,
    );

    return response?.path;
  }

  Future<String?> emailAndPasswordLogIn({
    required String email,
    required String password,
  }) async {
    state = state.reset();

    AuthenticationClientState? response =
        await _authenticationClient.emailAndPasswordLogIn(
      email: email,
      password: password,
    );

    state = state.copyWith(
      loading: false,
      error: response?.error,
      info: response?.info,
    );

    return response?.path;
  }

  Future<String?> logout() async {
    state = state.reset();

    AuthenticationClientState? response = await _authenticationClient.signOut();

    state = state.copyWith(
      loading: false,
      error: response?.error,
      info: response?.info,
    );

    return response?.path;
  }

  Future<String?> resetPassword(String email) async {
    state = state.reset();

    AuthenticationClientState? response =
        await _authenticationClient.resetPassword(email);

    state = state.copyWith(
      loading: false,
      error: response?.error,
      info: response?.info,
    );

    return response?.info;
  }
}

final authenticationClientStateProvider = StateNotifierProvider<
    AuthenticationClientNotifier,
    AuthenticationClientState>((_) => AuthenticationClientNotifier());

final newPageProvider = StateProvider.autoDispose<int>((ref) => 0);

final userDataProvider = FutureProvider<dynamic>((ref) async {
  return ref.read(authenticationProvider).getUserData();
});
