import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sudanese_job_finder/util/dialog.dart';

void connectionError(BuildContext context) {
  errorDialog(
    context: context,
    errorTitle: 'Connection Error',
    errorDescription: 'Plz, Check your network connection',
  );
}

void connectionTimeout(BuildContext context) {
  errorDialog(
    context: context,
    errorTitle: 'Connection timed out',
    errorDescription: 'Please try again',
  );
}

// void checkInfoError(BuildContext context) {
//   errorDialog(
//     context: context,
//     errorTitle: 'Error',
//     errorDescription: 'Please check the entered data',
//   );
// }

void fillAllFieldError(BuildContext context) {
  errorDialog(
    context: context,
    errorTitle: 'Error',
    errorDescription: 'Plz, fill all fields',
  );
}

void emailFormatError(BuildContext context) {
  errorDialog(
    context: context,
    errorTitle: 'Error',
    errorDescription: 'Plz, Check you email format',
  );
}

void passwordLenghtError(BuildContext context) {
  errorDialog(
    context: context,
    errorTitle: 'Error',
    errorDescription: 'Password should be between 7 and 12 characters.',
  );
}

void unhandledExceptionMessage(BuildContext context) {
  errorDialog(
    context: context,
    errorTitle: 'an error occurred',
    errorDescription: 'Please try again',
  );
}

void authServiceError(BuildContext context, DioException err) {
  if (err.type == DioExceptionType.connectionTimeout ||
      err.type == DioExceptionType.receiveTimeout ||
      err.type == DioExceptionType.sendTimeout) {
    connectionTimeout(context);
  } else if (err.type == DioExceptionType.unknown &&
      err.error is SocketException) {
    connectionError(context);
  } else {
    unhandledExceptionMessage(context);
  }
}
