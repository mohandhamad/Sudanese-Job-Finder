import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sudanese_job_finder/constant/app_color.dart';
import 'package:sudanese_job_finder/constant/app_config.dart';
import 'package:sudanese_job_finder/constant/app_route.dart';
import 'package:sudanese_job_finder/constant/app_strings.dart';
import 'package:sudanese_job_finder/model/register_request.dart';
import 'package:sudanese_job_finder/services/auth_services.dart';
import 'package:sudanese_job_finder/util/dialog.dart';
import 'package:sudanese_job_finder/util/errors.dart';
import 'package:sudanese_job_finder/widget/global/app_bar_widget.dart';
import 'package:sudanese_job_finder/widget/global/btn_widget.dart';
import 'package:sudanese_job_finder/widget/authentication_widget/txt_field_widget.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthServices _api = AuthServices();
  bool _isLoading = false;
  bool _isPasswordVisible = false;
  String? _selectedUserType;

  void register(String url, int groups) {
    setState(() => _isLoading = true);

    // Validation checks
    if (_usernameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _passwordController.text.isEmpty) {
      setState(() => _isLoading = false);
      fillAllFieldError(context);
      return;
    }

    if (!EmailValidator.validate(_emailController.text)) {
      setState(() => _isLoading = false);
      emailFormatError(context);
      return;
    }

    RegisterRequest payload = RegisterRequest(
      username: _usernameController.text.trim().toLowerCase(),
      email: _emailController.text.trim().toLowerCase(),
      password: _passwordController.text.trim(),
      groups: [groups],
    );

    _api.register(context, url, payload).then((response) {
      if (response) {
        successDialog(
          context: context,
          errorTitle: "Success",
          errorDescription: "Please check your email for a verification link.",
        );
        //if (mounted) GoRouter.of(context).pushNamed(AppRoute.loginRouteName);
      }
      if (mounted) setState(() => _isLoading = false);
    });
  }

  @override
  void dispose() {
    _api.close();
    super.dispose();
    _emailController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset:
          false, // prevent form shifting when keyboard appears
      backgroundColor: const Color.fromARGB(255, 244, 241, 241),
      appBar: const AppBarWidget(isHome: false),
      body: Stack(
        children: [
          // Background image fills the screen
          const Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AppStrings.appBackground),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.matrix([
                    0.0,
                    0.0,
                    0.0,
                    0.0,
                    0.0,
                    187.0,
                    187.0,
                    187.0,
                    187.0,
                    187.0,
                    255.0,
                    255.0,
                    255.0,
                    255.0,
                    255.0,
                    1.0,
                    1.0,
                    1.0,
                    1.0,
                    1.0,
                  ]),
                ),
              ),
            ),
          ),
          // Fixed registration form (non-scrollable)
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Logo inside the card at the top
                      Center(
                        child: Image.asset(
                          AppStrings.appLogo,
                          height: 80,
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Center(
                        child: Text(
                          "Register Account",
                          style: TextStyle(
                            color: AppColor.appPrimaryColor,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      Row(
                        children: [
                          Expanded(
                            child: _UserTypeButton(
                              title: "JobSeeker",
                              icon: Icons.work,
                              isSelected: _selectedUserType == '4',
                              onTap: () =>
                                  setState(() => _selectedUserType = '4'),
                            ),
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            child: _UserTypeButton(
                              title: "Employer",
                              icon: Icons.business,
                              isSelected: _selectedUserType == '2',
                              onTap: () =>
                                  setState(() => _selectedUserType = '2'),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      TxtFieldWidget(
                        controller: _usernameController,
                        hintText: "username",
                        textInputType: TextInputType.name,
                        icon: Icons.person_outline,
                      ),
                      const SizedBox(height: 20),
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
                            _isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.grey,
                          ),
                          onPressed: () => setState(
                              () => _isPasswordVisible = !_isPasswordVisible),
                        ),
                      ),
                      const SizedBox(height: 30),
                      _isLoading
                          ? const Center(child: CircularProgressIndicator())
                          : BtnWidget(
                              btnName: "SIGN UP",
                              voidCallback: () {
                                if (_selectedUserType == '4') {
                                  register(AppConfig.jobSeekerRegisterURL, 4);
                                } else if (_selectedUserType == '2') {
                                  register(AppConfig.companyRegisterURL, 2);
                                } else {
                                  errorDialog(
                                    context: context,
                                    errorTitle: 'Error',
                                    errorDescription: 'Please select user type',
                                  );
                                }
                              },
                            ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                        child: Text.rich(
                          TextSpan(
                            text: "Already have an account? ",
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                            ),
                            children: [
                              TextSpan(
                                text: "Login",
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
          )
        ],
      ),
    );
  }
}

class _UserTypeButton extends StatelessWidget {
  final String title;
  final bool isSelected;
  final IconData icon; // new property for icon
  final VoidCallback onTap;

  const _UserTypeButton({
    required this.title,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onTap,
      style: OutlinedButton.styleFrom(
        backgroundColor:
            isSelected ? AppColor.appPrimaryColor.withOpacity(0.1) : null,
        side: BorderSide(
          color: isSelected ? AppColor.appPrimaryColor : Colors.grey,
          width: 1.5,
        ),
        padding: const EdgeInsets.symmetric(vertical: 18),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: isSelected ? AppColor.appPrimaryColor : Colors.grey,
          ),
          const SizedBox(width: 8),
          Text(
            title,
            style: TextStyle(
              color: isSelected ? AppColor.appPrimaryColor : Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
