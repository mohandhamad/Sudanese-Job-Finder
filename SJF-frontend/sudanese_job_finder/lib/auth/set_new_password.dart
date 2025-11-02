import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sudanese_job_finder/constant/app_color.dart';
import 'package:sudanese_job_finder/constant/app_route.dart';
import 'package:sudanese_job_finder/constant/app_strings.dart';
import 'package:sudanese_job_finder/model/set_new_password_response.dart';
import 'package:sudanese_job_finder/services/auth_services.dart';
import 'package:sudanese_job_finder/util/dialog.dart';
import 'package:sudanese_job_finder/util/errors.dart';
import 'package:sudanese_job_finder/widget/authentication_widget/txt_field_widget.dart';
import 'package:sudanese_job_finder/widget/global/btn_widget.dart';

// ليست مستخدمة

class SetNewPassword extends StatefulWidget {
  final String? uidb64;
  final String? token;
  const SetNewPassword({super.key, this.uidb64, this.token});

  @override
  State<SetNewPassword> createState() => _SetNewPasswordState();
}

class _SetNewPasswordState extends State<SetNewPassword> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _password2Controller = TextEditingController();
  final AuthServices _api = AuthServices();
  bool _isLoading = false;

  void setNewPassword() {
    setState(() => _isLoading = true);
    if (_passwordController.text.isEmpty || _password2Controller.text.isEmpty) {
      setState(() => _isLoading = false);
      fillAllFieldError(context);
      return;
    }
    if (_passwordController.text != _password2Controller.text) {
      setState(() => _isLoading = false);
      errorDialog(
        context: context,
        errorTitle: 'Error',
        errorDescription: 'Password must be matching.',
      );
      return;
    }
    if (_passwordController.text.length > 12 ||
        _passwordController.text.length < 7) {
      setState(() => _isLoading = false);
      passwordLenghtError(context);
      return;
    }
    SetNewPasswordResponse payload = SetNewPasswordResponse(
      password: _passwordController.text.trim(),
      confirmPassword: _password2Controller.text.trim(),
      uidb64: widget.uidb64,
      token: widget.token,
    );
    try {
      _api.setNewPassword(context, payload).then((response) {
        if (response) {
          _passwordController.clear();
          _password2Controller.clear();
          successDialog(
            context: context,
            errorTitle: "Success",
            errorDescription:
                "Your password has been successfully changed. Please use the new password for future logins.",
          );
          GoRouter.of(context)
              .pushReplacementNamed(AppRoute.onboardingRouteName);
        }
        setState(() => _isLoading = false);
      });
    } catch (_) {
      setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    _api.close();
    super.dispose();
    _passwordController.dispose();
    _password2Controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Container(
          // margin: const EdgeInsets.symmetric(horizontal: 20),
          height: height,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AppStrings.appBackground),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.matrix([
                0.0, 0.0, 0.0, 0.0, 0.0, // Red channel
                187.0, 187.0, 187.0, 187.0, 187.0, // Green channel
                255.0, 255.0, 255.0, 255.0, 255.0, // Blue channel
                1.0, 1.0, 1.0, 1.0, 1.0, // Alpha channel
              ]),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 70),
                const Text(
                  "Reset Password",
                  style: TextStyle(
                    color: AppColor.appPrimaryColor,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  "Plz, Enter your email to reset your Password.",
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 20),
                TxtFieldWidget(
                  controller: _passwordController,
                  hintText: "Password",
                  textInputType: TextInputType.visiblePassword,
                  icon: Icons.lock,
                  isPassword: true,
                ),
                TxtFieldWidget(
                  controller: _password2Controller,
                  hintText: "Reenter Password",
                  textInputType: TextInputType.visiblePassword,
                  icon: Icons.lock,
                  isPassword: true,
                ),
                const SizedBox(height: 20),
                _isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: AppColor.appPrimaryColor,
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: BtnWidget(
                          btnName: "Save",
                          voidCallback: () {
                            setNewPassword();
                          },
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
