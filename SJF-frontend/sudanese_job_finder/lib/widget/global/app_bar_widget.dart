import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool isHome;
  final Color? contentColor;
  const AppBarWidget({
    super.key,
    this.title,
    required this.isHome,
    this.contentColor,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      title: Text(
        title ?? '',
        style: TextStyle(
          color: contentColor ?? Theme.of(context).focusColor,
        ),
      ),
      leading: isHome
          ? IconButton(
              onPressed: () {
                if (ZoomDrawer.of(context)!.isOpen()) {
                  ZoomDrawer.of(context)!.close();
                } else {
                  ZoomDrawer.of(context)!.open();
                }
              },
              icon: Icon(
                Icons.menu,
                color: Theme.of(context).focusColor,
              ),
            )
          : IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: contentColor ?? Theme.of(context).focusColor,
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
      centerTitle: true,
      elevation: 0,
    );
  }
}
