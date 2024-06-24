import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_language_learning/api/authentication_api.dart';
import 'package:sign_language_learning/models/user.dart';
import 'package:sign_language_learning/pages/home_page.dart';
import 'package:sign_language_learning/pages/welcome_page.dart';
import 'package:sign_language_learning/providers.dart';

enum AuthProvider { password, google }

class AuthenticationClient {
  final AuthenticationApi _authenticationApi;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  AuthenticationClient(this._authenticationApi);

  Future<dynamic> getUserData() {
    return _db.collection('users').doc(_auth.currentUser!.uid).get();
  }

  Future<AuthenticationClientState?> googleSignIn() async {
    final GoogleSignInAccount? account =
        await _authenticationApi.signInWithGoogle();
    if (account == null) {
      return null;
    }
    final googleAuth = await account.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    UserCredential userCredential =
        await _auth.signInWithCredential(credential);

    updateUserData(userCredential.user, AuthProvider.google);

    return const AuthenticationClientState(
      path: HomePage.routeName,
    );
  }

  Future<AuthenticationClientState?> emailAndPasswordSignIn({
    required email,
    required password,
  }) async {
    UserCredential? userCredential;
    try {
      userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return const AuthenticationClientState(
          error: 'La contraseña proporcionada es demasiado débil.',
        );
      } else if (e.code == 'email-already-in-use') {
        return const AuthenticationClientState(
          error: 'El correo electrónico ya está en uso.',
        );
      }
    } catch (e) {
      return const AuthenticationClientState(
        error: 'Ocurrió un error inesperado.',
      );
    }

    updateUserData(userCredential!.user, AuthProvider.password);

    return const AuthenticationClientState(
      path: HomePage.routeName,
    );
  }

  Future<AuthenticationClientState?> emailAndPasswordLogIn({
    required email,
    required password,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      return const AuthenticationClientState(
        error: 'El usuario o la contraseña son incorrectos.',
      );
    } catch (e) {
      return const AuthenticationClientState(
        error: 'Ocurrió un error inesperado.',
      );
    }

    return const AuthenticationClientState(
      path: HomePage.routeName,
    );
  }

  void updateUserData(User? user, AuthProvider authProvider) async {
    if (user == null) {
      return;
    }
    DocumentReference ref = _db.collection('users').doc(user.uid);

    return ref.set({
      'uid': user.uid,
      'email': user.email,
      'displayName': user.displayName,
      'authProvider': authProvider.toString(),
    }, SetOptions(merge: true));
  }

  Future<AuthenticationClientState?> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (error) {
      switch (error.code) {
        case 'user-not-found':
          break;
        case 'invalid-email':
          return const AuthenticationClientState(
            error: 'Ingresa un correo válido.',
          );
        default:
          return const AuthenticationClientState(
            error: 'Ocurrió un error inesperado.',
          );
      }
    } catch (e) {
      return const AuthenticationClientState(
        error: 'Ocurrió un error inesperado.',
      );
    }

    return const AuthenticationClientState(
        info:
            'En caso que el correo esté asociado a una cuenta, recibirás un correo dentro de poco');
  }

  // TODO: handle signOut when user already has deleted the account
  Future<AuthenticationClientState?> signOut() async {
    final docRef = _db.collection("users").doc(_auth.currentUser!.uid);

    final DocumentSnapshot document = await docRef.get();

    try {
      final data = document.data() as Map<String, dynamic>;
      if (data['authProvider'] == AuthProvider.google.toString()) {
        await _authenticationApi.googleLogout();
      }
    } catch (e) {
      return const AuthenticationClientState(
        error: 'Ocurrió un error inesperado.',
      );
    }

    _auth.signOut();

    return const AuthenticationClientState(
      path: WelcomePage.routeName,
    );
  }
}

final GoogleSignIn googleSignIn = GoogleSignIn();

final authenticationApi = AuthenticationApi(googleSignIn);
final authenticationProvider = Provider<AuthenticationClient>(
    (ref) => AuthenticationClient(authenticationApi));
