// ignore_for_file: use_build_context_synchronously
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sudanese_job_finder/constant/app_config.dart';
import 'package:sudanese_job_finder/constant/app_strings.dart';
import 'package:sudanese_job_finder/model/login_request.dart';
import 'package:sudanese_job_finder/model/login_response.dart';
import 'package:sudanese_job_finder/model/register_request.dart';
import 'package:sudanese_job_finder/model/set_new_password_response.dart';
import 'package:sudanese_job_finder/util/dialog.dart';
import 'package:sudanese_job_finder/util/errors.dart';
import 'package:sudanese_job_finder/util/secure_storage.dart';

class AuthServices {
  final Dio _dio = Dio(BaseOptions(
    connectTimeout: const Duration(minutes: 1),
    sendTimeout: const Duration(minutes: 1),
    receiveTimeout: const Duration(minutes: 1),
  ));

  void close() {
    _dio.close(force: true);
  }

  Future<bool> login(BuildContext context, LoginRequest payload) async {
    Map<String, String> requestHeaders = {'Content-Type': 'application/json'};
    try {
      final response = await _dio.post(
        '${AppConfig.apiURL}account/login/',
        data: payload,
        options: Options(headers: requestHeaders),
      );
      if (response.statusCode != 200) {
        unhandledExceptionMessage(context);
        return false;
      }
      await SecureStorage.writeSecureData(AppStrings.accessTokenKey,
          loginResponseFromJson(json.encode(response.data)).accessToken);
      await SecureStorage.writeSecureData(AppStrings.refreshTokenKey,
          loginResponseFromJson(json.encode(response.data)).refreshToken);

      return true;
    } on DioException catch (error) {
      if (error.response?.statusCode == 401) {
        final errorData = error.response?.data as Map<String, dynamic>;
        final errorMessage = errorData['detail'];
        // final errorMessages =
        //     errorData.values.expand((messages) => messages).toList();
        errorDialog(
          context: context,
          errorTitle: 'Error',
          errorDescription: errorMessage ?? '',
        );
        return false;
      }
      authServiceError(context, error);
      await SecureStorage.deleteSecureData(AppStrings.accessTokenKey);
      await SecureStorage.deleteSecureData(AppStrings.refreshTokenKey);
      return false;
    } catch (_) {
      await SecureStorage.deleteSecureData(AppStrings.accessTokenKey);
      await SecureStorage.deleteSecureData(AppStrings.refreshTokenKey);
      return false;
    }
  }

  Future<bool> register(
      BuildContext context, String url, RegisterRequest payload) async {
    Map<String, String> requestHeaders = {'Content-Type': 'application/json'};
    try {
      final response = await _dio.post(
        '${AppConfig.apiURL}$url',
        data: payload,
        options: Options(headers: requestHeaders),
      );
      if (response.statusCode == 201) {
        return true;
      }
      return false;
    } on DioException catch (error) {
      if (error.response?.statusCode == 400 &&
          error.response?.data is Map<String, dynamic>) {
        final errorData = error.response?.data as Map<String, dynamic>;
        final errorMessages =
            errorData.values.expand((messages) => messages).toList();
        errorDialog(
          context: context,
          errorTitle: 'Error',
          errorDescription: errorMessages[0] ?? '',
        );
        return false;
      }
      authServiceError(context, error);
      return false;
    } catch (_) {
      return false;
    }
  }

  Future<bool> resetPassword(
      BuildContext context, Map<String, String> payload) async {
    Map<String, String> requestHeaders = {'Content-Type': 'application/json'};
    try {
      final response = await _dio.post(
        '${AppConfig.apiURL}account/password-reset/',
        data: payload,
        options: Options(headers: requestHeaders),
      );
      if (response.statusCode == 200) return true;
      return false;
    } on DioException catch (error) {
      if (error.response?.statusCode == 404) {
        final errorData = error.response?.data as Map<String, dynamic>;
        final errorMessage = errorData['error'];
        errorDialog(
          context: context,
          errorTitle: 'Error',
          errorDescription: errorMessage ?? '',
        );
        return false;
      }
      authServiceError(context, error);
      return false;
    } catch (_) {
      return false;
    }
  }

  Future<bool> setNewPassword(
      BuildContext context, SetNewPasswordResponse payload) async {
    Map<String, String> requestHeaders = {'Content-Type': 'application/json'};
    try {
      final response = await _dio.patch(
        '${AppConfig.apiURL}account/set-new-password/',
        data: payload,
        options: Options(headers: requestHeaders),
      );
      if (response.statusCode == 200) return true;
      return false;
    } on DioException catch (error) {
      if (error.response?.statusCode == 401) {
        final errorData = error.response?.data as Map<String, dynamic>;
        final errorMessage = errorData['detail'];
        errorDialog(
          context: context,
          errorTitle: 'Error',
          errorDescription: errorMessage ?? '',
        );
        return false;
      }
      authServiceError(context, error);
      return false;
    } catch (_) {
      return false;
    }
  }
}
