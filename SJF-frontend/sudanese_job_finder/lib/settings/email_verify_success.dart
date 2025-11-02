import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sudanese_job_finder/constant/app_route.dart';
import 'package:sudanese_job_finder/constant/app_strings.dart';
import 'package:sudanese_job_finder/widget/global/btn_widget.dart';

class EmailVerifySuccess extends StatelessWidget {
  const EmailVerifySuccess({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            const Spacer(),
            Image.asset(AppStrings.appSuccess, width: width * 0.6,),
            const Text(
              'Verification success',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Congratulations! Your account has been successfully verified. You can now enjoy all the benefits and features our platform has to offer.',
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