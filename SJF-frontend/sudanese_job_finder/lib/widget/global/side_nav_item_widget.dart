import 'package:flutter/material.dart';

class SideNavItemWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback voidCallback;
  const SideNavItemWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.voidCallback,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
      ),
      onTap: voidCallback,
    );
  }
}
