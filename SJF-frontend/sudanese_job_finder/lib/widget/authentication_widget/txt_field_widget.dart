import 'package:flutter/material.dart';
import 'package:sudanese_job_finder/constant/app_color.dart';

class TxtFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType textInputType;
  final String hintText;
  final IconData icon;
  final bool? isPassword;
  final Widget? suffixIcon;

  const TxtFieldWidget({
    super.key,
    required this.controller,
    required this.hintText,
    required this.textInputType,
    required this.icon,
    this.isPassword,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        boxShadow: AppColor.shadow,
      ),
      child: TextField(
        controller: controller,
        keyboardType: textInputType,
        obscureText: isPassword ?? false,
        // textAlign: TextAlign.center,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.grey),
          filled: true,
          fillColor: Theme.of(context).cardColor,
          prefixIcon: Icon(
            icon,
            color: Colors.grey,
          ),
          suffixIcon: suffixIcon,
          contentPadding: const EdgeInsets.all(10.0),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(15),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
    );
  }
}
