import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:sign_language_learning/data/authentication_client.dart';
import 'package:sign_language_learning/helpers/http.dart';
import 'package:sign_language_learning/helpers/http_response.dart';

//TODO: Add no internet connection error handling
class ResourcesApi {
  final Http _http;

  ResourcesApi(this._http);

  //TODO: Add corresponding response type
  Future<HttpResponse> updateAvatar(
      Uint8List bytes, String expectedLabel) async {
    return _http.request<String>(
      '/api/predict',
      method: 'POST',
      formData: {
        "file": MultipartFile.fromBytes(bytes, filename: "avatar.jpg"),
        "expected_label": expectedLabel
      },
    );
  }
}
