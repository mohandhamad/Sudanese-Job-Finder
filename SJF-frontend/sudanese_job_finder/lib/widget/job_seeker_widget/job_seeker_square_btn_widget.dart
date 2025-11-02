import 'package:flutter/material.dart';
import 'package:sudanese_job_finder/constant/app_color.dart';

class JobSeekerSquareBtnWidget extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback voidCallback;
  const JobSeekerSquareBtnWidget({
    super.key,
    required this.title,
    required this.icon,
    required this.voidCallback,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: voidCallback,
      child: Container(
        width: 150,
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: AppColor.shadow,
          gradient: const LinearGradient(
            colors: [AppColor.appPrimaryColor, Colors.purple],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              size: 90,
              color: Colors.white,
            ),
            const SizedBox(height: 4),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.white
              ),
            )
          ],
        ),
      ),
    );
  }
}
