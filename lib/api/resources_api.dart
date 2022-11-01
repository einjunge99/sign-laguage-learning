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
  Future<HttpResponse> updateAvatar(
      Uint8List bytes, String expectedLabel) async {
    //TODO: Add corresponding response type
    return _http.request(
      '/api/predict',
      method: 'POST',
      formData: {
        "file": MultipartFile.fromBytes(bytes, filename: "avatar.jpg"),
        "expected_label": expectedLabel
      },
    );
  }

  Future<HttpResponse> getLectures() async {
    final uid = _auth.currentUser?.uid;
    return _http.request(
      '/api/lectures/$uid',
    );
  }

  Future<HttpResponse> getExercises(String lectureId) async {
    return _http.request(
      '/api/exercises/$lectureId',
    );
  }

  Future<HttpResponse> updateLectureStatus(String lectureId) async {
    final uid = _auth.currentUser?.uid;
    return _http.request(
      '/api/user/$uid/$lectureId',
      method: 'PATCH',
    );
  }
}
