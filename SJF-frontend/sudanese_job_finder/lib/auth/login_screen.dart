import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sudanese_job_finder/constant/app_color.dart';
import 'package:sudanese_job_finder/constant/app_route.dart';
import 'package:sudanese_job_finder/constant/app_strings.dart';
import 'package:sudanese_job_finder/model/login_request.dart';
import 'package:sudanese_job_finder/services/auth_services.dart';
import 'package:sudanese_job_finder/util/errors.dart';
import 'package:sudanese_job_finder/util/toast.dart';
import 'package:sudanese_job_finder/widget/global/app_bar_widget.dart';
import 'package:sudanese_job_finder/widget/global/btn_widget.dart';
//import 'package:sudanese_job_finder/widget/global/txt_btn_widget.dart';
import 'package:sudanese_job_finder/widget/authentication_widget/txt_field_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthServices _api = AuthServices();
  bool _isLoading = false;
  bool _isPasswordVisible = false;
  bool _rememberMe = false; // new variable

  void login() {
    setState(() => _isLoading = true);
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      setState(() => _isLoading = false);
      fillAllFieldError(context);
      return;
    }
    if (!EmailValidator.validate(_emailController.text)) {
      setState(() => _isLoading = false);
      emailFormatError(context);
      return;
    }
    LoginRequest payload = LoginRequest(
      email: _emailController.text.trim().toLowerCase(),
      password: _passwordController.text.trim(),
    );
    try {
      _api.login(context, payload).then((response) {
        if (response) {
          _emailController.clear();
          _passwordController.clear();
          successToast("Login successful.");
          GoRouter.of(context).pushReplacementNamed(AppRoute.tempRouteName);
        }
        if (mounted) setState(() => _isLoading = false);
      });
    } catch (_) {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    _api.close();
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: const Color.fromARGB(255, 244, 241, 241),
      resizeToAvoidBottomInset: false, // Prevents resizing when keyboard appears
      appBar: const AppBarWidget(isHome: false),
      body: Stack(
        children: [
          // Full-screen background image
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
          // Fixed login form (non-scrollable)
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
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Logo placed inside the card at the top
                      Center(
                        child: Image.asset(
                          AppStrings.appLogo,
                          height: 80,
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Center(
                        child: Text(
                          "Login",
                          style: TextStyle(
                            color: AppColor.appPrimaryColor,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      TxtFieldWidget(
                        controller: _emailController,
                        hintText: "Email",
                        textInputType: TextInputType.emailAddress,
                        icon: Icons.email_outlined,
                      ),
                      const SizedBox(height: 20),
                      TxtFieldWidget(
                        controller: _passwordController,
                        hintText: "Password",
                        isPassword: !_isPasswordVisible,
                        textInputType: TextInputType.visiblePassword,
                        icon: Icons.lock_outline,
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                            color: Colors.grey,
                          ),
                          onPressed: () => setState(() => _isPasswordVisible = !_isPasswordVisible),
                        ),
                      ),
                      const SizedBox(height: 20),
                      // New Row with "Remember me" checkbox and "Forgot Password?" button
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                value: _rememberMe,
                                activeColor: AppColor.appPrimaryColor,
                                onChanged: (value) {
                                  setState(() {
                                    _rememberMe = value!;
                                  });
                                },
                              ),
                              const Text(
                                "Remember me",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                          RichText(
                            text: TextSpan(
                              text: "Forgot Password?",
                              style: const TextStyle(
                                color: AppColor.appPrimaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => GoRouter.of(context).pushNamed(AppRoute.resetPasswordRouteName),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      _isLoading
                          ? const Center(child: CircularProgressIndicator())
                          : BtnWidget(
                              btnName: "LOGIN",
                              voidCallback: login,
                            ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                        child: Text.rich(
                          TextSpan(
                            text: "Don't have an account? ",
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                            ),
                            children: [
                              TextSpan(
                                text: "Register",
                                style: const TextStyle(
                                  color: AppColor.appPrimaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () => GoRouter.of(context).pushNamed(AppRoute.registerRouteName),
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
