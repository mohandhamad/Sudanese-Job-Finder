import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:sudanese_job_finder/constant/app_color.dart';

void errorDialog({
  required BuildContext context,
  required String errorTitle,
  required String errorDescription,
  VoidCallback? voidCallback,
  VoidCallback? voidCallbackCancel,
  double? width,
  String? btnTitle,
  String? btnCancelTitle,
}) {
  AwesomeDialog(
    width: width,
    context: context,
    dialogType: DialogType.error,
    animType: AnimType.rightSlide,
    title: errorTitle,
    desc: errorDescription,
    btnOkText: btnTitle ?? 'Close',
    btnOkOnPress: voidCallback ??
        () {
          Navigator.canPop(context);
        },
    btnCancelText: btnCancelTitle,
    btnCancelOnPress: voidCallbackCancel,
    btnOkColor: AppColor.appPrimaryColor,
  ).show();
}

void successDialog({
  required BuildContext context,
  required String errorTitle,
  required String errorDescription,
  VoidCallback? voidCallback,
  String? btnTitle,
}) {
  AwesomeDialog(
    context: context,
    dialogType: DialogType.success,
    animType: AnimType.rightSlide,
    title: errorTitle,
    desc: errorDescription,
    btnOkText: btnTitle ?? 'Close',
    btnOkOnPress: voidCallback ??
        () {
          Navigator.canPop(context);
        },
    btnOkColor: AppColor.appPrimaryColor,
  ).show();
}
