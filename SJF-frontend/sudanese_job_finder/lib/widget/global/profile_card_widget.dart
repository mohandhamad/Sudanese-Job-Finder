import 'package:flutter/material.dart';
import 'package:sudanese_job_finder/constant/app_color.dart';

class ProfileCardWidget extends StatelessWidget {
  final VoidCallback voidCallback;
  const ProfileCardWidget({super.key, required this.voidCallback});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return InkWell(
      onTap: voidCallback,
      child: Container(
        height: height * 0.15,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          boxShadow: AppColor.shadow,
          gradient: const LinearGradient(
            colors: [Color(0xFFFFD54F), Color(0xFFFFCA28), Colors.orange],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Gallery',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(
                  Icons.camera_enhance_rounded,
                  shadows: AppColor.shadow,
                  color: Colors.white,
                  size: height * 0.07,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
