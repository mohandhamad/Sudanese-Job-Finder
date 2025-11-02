import 'package:flutter/material.dart';
import 'package:sudanese_job_finder/constant/app_color.dart';

class TxtBtnWidget extends StatelessWidget {
  final VoidCallback voidCallback;
  final String btnName;
  final Color? color;
  final double? txtSize;
  const TxtBtnWidget({
    super.key,
    required this.voidCallback,
    required this.btnName,
    this.color,
    this.txtSize,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: voidCallback,
      child: Text(
        btnName,
        style: TextStyle(
          fontSize: txtSize,
          color: color ?? AppColor.appTxtBtnColor,
        ),
      ),
    );
  }
}
