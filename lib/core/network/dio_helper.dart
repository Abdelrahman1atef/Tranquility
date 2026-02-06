import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../views/login/view.dart';
import '../logic/cash_helper.dart';
import '../logic/helper_methods.dart';


String baseUrl = "https://tranquility.growfet.com/";
Duration apiTimeOut = const Duration(seconds: 50);

enum DataStates { uninitialized, loading, loaded, error }

class CustomResponse<T> {
  final bool isSuccess;
  final T? data;
  final String? msg;

  CustomResponse({required this.isSuccess,  this.data, this.msg});
}

class DioHelper {
  static final Dio _dio = Dio()
    ..options.baseUrl = baseUrl
    ..options.headers = {"Accept": "application/json"}
    ..options.validateStatus = (status) {
      return status != null && status < 500;
    }
    ..options.connectTimeout = apiTimeOut
    ..options.receiveTimeout = apiTimeOut
    ..options.sendTimeout = apiTimeOut
    ..interceptors.addAll({
      PrettyDioLogger(request: true, requestBody: true, responseBody: true, error: true),
      InterceptorsWrapper(
        onError: (error, handler) {
          if (error.response?.statusCode == 401) {
            CashHelper.removeUserData();
            goto(const LoginView(), canPop: false);
          }
        },
      ),
    });

  static CustomResponse<T> _handleResponse<T>(Response<T> response) {
    final isSuccess = response.statusCode != null &&
        response.statusCode! >= 200 &&
        response.statusCode! < 300;

    final dynamic body = response.data;

    String? message;

    if (body is Map<String, dynamic>) {
      message = body["message"]?.toString();
    }

    return CustomResponse<T>(
      isSuccess: isSuccess,
      data: body as T?,
      msg: message,
    );
  }


  static Future<CustomResponse<T>> postData<T>({
    required String endpoint,
     dynamic data,
    dynamic queryParameters,
  }) async {
    var token = CashHelper.getToken();
    _dio.options.headers.addAll({"Authorization": "Bearer $token"});
    try {
      final response = await _dio.post<T>(endpoint, queryParameters: queryParameters, data: data);
      return _handleResponse(response);
    } on DioException catch (ex) {
      return CustomResponse(isSuccess: false, data: ex.response?.data);
    }
  }

  static Future<CustomResponse<T>> putData<T>({required String endpoint,dynamic queryParameters,  dynamic data}) async {
    var token = CashHelper.getToken();
    _dio.options.headers.addAll({"Authorization": "Bearer $token"});
    try {
      final response = await _dio.put<T>(endpoint, data: data,queryParameters: queryParameters);
      return _handleResponse(response);
    } on DioException catch (ex) {
      return CustomResponse(isSuccess: false, data: ex.response?.data);
    }
  }

  static Future<CustomResponse<T>> getData<T>(String endpoint, [dynamic queryParameters]) async {
    var token = CashHelper.getToken();
    _dio.options.headers.addAll({"Authorization": "Bearer $token"});
    try {
      final response = await _dio.get<T>(endpoint, queryParameters: queryParameters);
      return _handleResponse(response);
    } on DioException catch (ex) {
      return CustomResponse(isSuccess: false, msg: ex.message);
    }
  }
  static Future<CustomResponse<T>> deleteData<T>({required String endpoint}) async {
    var token = CashHelper.getToken();
    _dio.options.headers.addAll({"Authorization": "Bearer $token"});
    try {
      final response = await _dio.delete<T>(endpoint);

      return _handleResponse(response);
    } on DioException catch (ex) {
      return CustomResponse(isSuccess: false, msg: ex.message);
    }
  }
}
