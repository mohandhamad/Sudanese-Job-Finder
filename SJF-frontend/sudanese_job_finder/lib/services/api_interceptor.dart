import 'dart:io';
import 'package:dio/dio.dart';
import 'package:sudanese_job_finder/constant/app_config.dart';
import 'package:sudanese_job_finder/constant/app_strings.dart';
import 'package:sudanese_job_finder/util/secure_storage.dart';

class ApiInterceptor extends Interceptor {
  ApiInterceptor({
    required this.onLogout,
    required this.dio,
    required this.onConnectionError,
    required this.timeoutConnection,
  });

  bool connectionErrorShown = false;

  final Function onLogout;
  final Dio dio;
  final Function onConnectionError;
  final Function timeoutConnection;

  bool isRefreshingToken = false;

  @override
  Future<void> onResponse(
      Response response, ResponseInterceptorHandler handler) async {
    handler.next(response);
  }

  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final accessToken =
        await SecureStorage.readSecureData(AppStrings.accessTokenKey);
    if (accessToken != null) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    }
    handler.next(options);
  }

  Future<void> _handleLogoutAndNavigate() async {
    await SecureStorage.deleteSecureData(AppStrings.accessTokenKey);
    await SecureStorage.deleteSecureData(AppStrings.refreshTokenKey);
    onLogout();
  }

  @override
  Future<void> onError(
      DioException err, ErrorInterceptorHandler handler) async {
    if (err.type == DioExceptionType.connectionTimeout ||
        err.type == DioExceptionType.receiveTimeout ||
        err.type == DioExceptionType.sendTimeout) {
      timeoutConnection();
      handler.reject(err);
      return;
    }

    if (err.type == DioExceptionType.unknown && err.error is SocketException) {
      if (!connectionErrorShown) {
        onConnectionError();
        connectionErrorShown = true;
      }
      await Future.delayed(const Duration(seconds: 5));
      return _retryWithBackoff(err, handler);
    }

    if (err.response?.statusCode == 401 && !isRefreshingToken) {
      connectionErrorShown = false;
      isRefreshingToken = true;

      final refreshToken =
          await SecureStorage.readSecureData(AppStrings.refreshTokenKey);
      if (refreshToken != null) {
        try {
          final response = await dio.post(
            '${AppConfig.apiURL}account/token/refresh/',
            data: {'refresh': refreshToken},
          );
          final newAccessToken = response.data['access'];
          // final newRefreshToken = response.data['refresh_token'];

          await SecureStorage.writeSecureData(
              AppStrings.accessTokenKey, newAccessToken);
          // await SecureStorage.writeSecureData(AppStrings.refreshToken, newRefreshToken);

          err.requestOptions.headers['Authorization'] =
              'Bearer $newAccessToken';
          final newResponse = await dio.fetch(err.requestOptions);
          handler.resolve(newResponse);
        } on DioException catch (e) {
          if(e.response?.statusCode == 401){
            await _handleLogoutAndNavigate();
          }
          handler.reject(e);
        }
      } else {
        await _handleLogoutAndNavigate();
        handler.reject(err);
        return;
      }

      isRefreshingToken = false;
    } else {
      connectionErrorShown = false;
      handler.reject(err);
      return;
    }
  }

  Future<void> _retryWithBackoff(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    dio
        .request(
      err.requestOptions.path,
      cancelToken: err.requestOptions.cancelToken,
      data: err.requestOptions.data,
      onReceiveProgress: err.requestOptions.onReceiveProgress,
      onSendProgress: err.requestOptions.onSendProgress,
      queryParameters: err.requestOptions.queryParameters,
      options: Options(
        method: err.requestOptions.method,
        headers: err.requestOptions.headers,
        contentType: err.requestOptions.contentType,
        responseType: err.requestOptions.responseType,
        followRedirects: err.requestOptions.followRedirects,
        validateStatus: err.requestOptions.validateStatus,
        receiveTimeout: err.requestOptions.receiveTimeout,
        sendTimeout: err.requestOptions.sendTimeout,
      ),
    )
        .then((response) {
      connectionErrorShown = false;
      handler.resolve(response);
    }).catchError(
      (e) async {
        connectionErrorShown = false;
        handler.next(e);
      },
    );
  }
}
