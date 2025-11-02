import 'package:flutter/material.dart';
import 'package:sudanese_job_finder/constant/app_color.dart';

class BtnWidget extends StatelessWidget {
  final String btnName;
  final VoidCallback voidCallback;
  final Color? color;
  final double? radius;
  final Color? textColor;
  const BtnWidget({
    super.key,
    required this.btnName,
    required this.voidCallback,
    this.color,
    this.radius,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: voidCallback,
      style: ElevatedButton.styleFrom(
        backgroundColor: color ?? AppColor.appBtnColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius ?? 10),
        ),
        fixedSize: Size(MediaQuery.of(context).size.width - 40, 47),
      ),
      child: Text(
        btnName,
        style: TextStyle(
          color: textColor ?? Colors.white,
        ),
      ),
    );
  }
}
