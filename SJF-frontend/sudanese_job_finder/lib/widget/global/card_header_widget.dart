import 'package:flutter/material.dart';
import 'package:sudanese_job_finder/constant/app_color.dart';

class CardHeaderWidget extends StatelessWidget {
  final String title;
  final IconData icon;
  final String? subTitle;
  final VoidCallback voidCallback;
  const CardHeaderWidget({
    super.key,
    required this.title,
    this.subTitle,
    required this.voidCallback, required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(
          color: AppColor.appPrimaryColor,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      subtitle: subTitle != null ? Text(subTitle ?? '') : null,
      trailing: IconButton(
        onPressed: voidCallback,
        icon: Icon(
          icon,
          color: AppColor.appPrimaryColor,
          size: 35,
        ),
      ),
    );
  }
}
