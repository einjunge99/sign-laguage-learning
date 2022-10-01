import 'package:dio/dio.dart';
import 'package:sign_language_learning/helpers/http_response.dart';
import 'package:sign_language_learning/utils/logs.dart';

class Http {
  late Dio _dio;
  late bool _logsEnabled;

  Http({
    required Dio dio,
    required bool logsEnabled,
  }) {
    _dio = dio;
    _logsEnabled = logsEnabled;
  }

  Future<HttpResponse<T>> request<T>(String path,
      {String method = 'GET',
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? data,
      Map<String, dynamic>? formData,
      Map<String, dynamic>? headers,
      T Function(dynamic data)? parser}) async {
    try {
      final response = await _dio.request(
        path,
        options: Options(
          method: method,
          headers: headers,
        ),
        queryParameters: queryParameters,
        data: formData != null ? FormData.fromMap(formData) : data,
      );
      Logs.p.i(response.data);
      if (parser != null) {
        return HttpResponse.success<T>(
          parser(response.data),
        );
      }
      return HttpResponse.success(response.data);
    } catch (e) {
      Logs.p.e(e);
      dynamic data;
      int statusCode = -1;
      String message = "unknown error";
      if (e is DioError) {
        message = e.message;
        if (e.response != null) {
          statusCode = e.response!.statusCode!;
          message = e.response!.statusMessage!;
          data = e.response!.data;
        }
      }
      return HttpResponse.fail(
        statusCode: statusCode,
        message: message,
        data: data,
      );
    }
  }
}
