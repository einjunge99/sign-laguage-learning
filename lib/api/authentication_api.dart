import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationApi {
  final GoogleSignIn _googleSignIn;

  AuthenticationApi(this._googleSignIn);

  Future<GoogleSignInAccount?> signInWithGoogle() {
    try {
      return _googleSignIn.signIn();
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<GoogleSignInAccount?> googleLogout() {
    return _googleSignIn.disconnect();
  }
}
