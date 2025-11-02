// ignore_for_file: use_build_context_synchronously

import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sudanese_job_finder/constant/app_color.dart';
import 'package:sudanese_job_finder/constant/app_route.dart';
import 'package:sudanese_job_finder/constant/app_strings.dart';
import 'package:sudanese_job_finder/services/auth_services.dart';
import 'package:sudanese_job_finder/util/dialog.dart';
import 'package:sudanese_job_finder/widget/global/app_bar_widget.dart';
import 'package:sudanese_job_finder/widget/global/btn_widget.dart';
import 'package:sudanese_job_finder/widget/authentication_widget/txt_field_widget.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController _controller = TextEditingController();
  final AuthServices _api = AuthServices();
  bool _isLoading = false;

  Future<void> resetPassword() async {
    setState(() => _isLoading = true);
    final email = _controller.text.trim();

    if (email.isEmpty) {
      errorDialog(
        context: context,
        errorTitle: 'Error',
        errorDescription: 'Please enter your email address',
      );
      setState(() => _isLoading = false);
      return;
    }

    if (!EmailValidator.validate(email)) {
      errorDialog(
        context: context,
        errorTitle: 'Error',
        errorDescription: 'Please enter a valid email address',
      );
      setState(() => _isLoading = false);
      return;
    }

    try {
      final success = await _api.resetPassword(context, {'email': email});
      if (success) {
        successDialog(
          context: context,
          errorTitle: 'Success',
          errorDescription: 'Password reset link sent to your email',
        );
        _controller.clear();
        //if (mounted) GoRouter.of(context).pushNamed(AppRoute.loginRouteName);
      }
    } catch (e) {
      errorDialog(
        context: context,
        errorTitle: 'Error',
        errorDescription: 'Failed to send reset link. Please try again.',
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    _api.close();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      appBar: const AppBarWidget(isHome: false),
      body: Stack(
        children: [
          const Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AppStrings.appBackground),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.matrix([
                    0.0, 0.0, 0.0, 0.0, 0.0,
                    187.0, 187.0, 187.0, 187.0, 187.0,
                    255.0, 255.0, 255.0, 255.0, 255.0,
                    1.0, 1.0, 1.0, 1.0, 1.0,
                  ]),
                ),
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Card(
                color: Colors.white,
                elevation: 6,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 40,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Center(
                        child: Image.asset(
                          AppStrings.appLogo,
                          height: 80,
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Center(
                        child: Text(
                          "Reset Password",
                          style: TextStyle(
                            color: AppColor.appPrimaryColor,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          "Please enter your email to receive a password reset link",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      TxtFieldWidget(
                        controller: _controller,
                        hintText: "Email Address",
                        textInputType: TextInputType.emailAddress,
                        icon: Icons.email_outlined,
                      ),
                      const SizedBox(height: 40),
                      _isLoading
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: AppColor.appPrimaryColor,
                              ),
                            )
                          : BtnWidget(
                              btnName: "SEND RESET LINK",
                              voidCallback: resetPassword,
                            ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                        child: Text.rich(
                          TextSpan(
                            text: "Remember password? ",
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                            ),
                            children: [
                              TextSpan(
                                text: "Login here",
                                style: const TextStyle(
                                  color: AppColor.appPrimaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () => GoRouter.of(context).pushNamed(AppRoute.loginRouteName),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}