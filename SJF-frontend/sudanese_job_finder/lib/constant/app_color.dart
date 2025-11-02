import 'package:flutter/material.dart';

class AppColor {
  // App Colors
  static const appPrimaryColor = Color(0xFF2CBBEA);
  static const appSecondaryColor = Color(0xFFFFEB3B);

  // Appbar Color
  static const appBarColor = Color(0xFF2CBBEA);

  // Button Color
  static const appBtnColor = Color(0xFF2CBBEA);
  static const appTxtBtnColor = Color(0xFF2CBBEA);

  // side nav menu item background
  static const appSideNavColor = Color(0xFF2CBBEA);

  static List<BoxShadow> shadow = [
    BoxShadow(
        color: const Color(0xFF3D3D3D).withOpacity(0.5),
        spreadRadius: 2,
        blurRadius: 5,
        offset: const Offset(0, 3)),
  ];
}
