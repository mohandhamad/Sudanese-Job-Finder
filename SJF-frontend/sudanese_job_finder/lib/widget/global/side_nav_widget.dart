import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
// import 'package:sudanese_job_finder/constant/app_color.dart';

class SideNavWidget extends StatelessWidget {
  final Widget mainScreen;
  final Widget menuScreen;
  SideNavWidget({
    super.key,
    required this.mainScreen,
    required this.menuScreen,
  });

  final zoomDrawerController = ZoomDrawerController();

  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
      controller: zoomDrawerController,
      menuScreen: menuScreen,
      mainScreen: mainScreen,
      menuBackgroundColor: Colors.indigo,
      showShadow: true,
      style: DrawerStyle.defaultStyle,
      angle: 0,
      mainScreenScale: 0.25,
      mainScreenTapClose: true,
      menuScreenTapClose: true,
    );
  }
}
