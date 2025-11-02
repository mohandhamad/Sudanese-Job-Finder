import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sudanese_job_finder/constant/app_route.dart';
import 'package:sudanese_job_finder/constant/app_strings.dart';
import 'package:sudanese_job_finder/widget/global/btn_widget.dart';

class EmailVerifyError extends StatelessWidget {
  const EmailVerifyError({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            const Spacer(),
            Image.asset(AppStrings.appError, width: width * 0.8,),
            const Text(
              'Error',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Verification error: Invalid credentials. Please try change the password.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.3),
              child: BtnWidget(
                btnName: 'Home',
                voidCallback: () {
                  GoRouter.of(context)
                      .pushReplacementNamed(AppRoute.onboardingRouteName);
                },
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
