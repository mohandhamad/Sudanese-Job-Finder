import 'package:flutter/material.dart';
import 'package:sudanese_job_finder/constant/app_color.dart';

class FloatingBtnWidget extends StatelessWidget {
  final VoidCallback voidCallback;
  const FloatingBtnWidget({super.key, required this.voidCallback});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        backgroundColor: AppColor.appPrimaryColor,
        onPressed: voidCallback,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      );
  }
}