import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sign_language_learning/data/authentication_client.dart';
import 'package:sign_language_learning/helpers/http.dart';
import 'package:sign_language_learning/helpers/http_response.dart';

//TODO: Add no internet connection error handling
class ResourcesApi {
  final Http _http;

  ResourcesApi(this._http);
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //TODO: Add corresponding response type
  Future<HttpResponse> predict(
      Uint8List bytes, String label, String lectureId) async {
    //TODO: Add corresponding response type
    return _http.request(
      '/lectures/$lectureId/predict',
      method: 'POST',
      formData: {
        "file": MultipartFile.fromBytes(bytes, filename: "avatar.jpg"),
        "expected_label": label
      },
    );
  }

  Future<HttpResponse> getUserLectures() async {
    final uid = _auth.currentUser?.uid;
    return _http.request(
      '/users/$uid/lectures',
    );
  }

  Future<HttpResponse> getExercices(String lectureId) async {
    return _http.request(
      '/lectures/$lectureId/exercices',
    );
  }

  Future<HttpResponse> updateLectureStatus(String lectureId) async {
    final uid = _auth.currentUser?.uid;
    return _http.request('/users/$uid/completed-lectures',
        method: 'PATCH', data: {'lecture_id': lectureId});
  }

  Future<HttpResponse> getUserInfo() async {
    final uid = _auth.currentUser?.uid;
    return _http.request(
      '/users/$uid/',
    );
  }
}
