import 'package:flutter/material.dart';

class TabWidget extends StatelessWidget {
  final IconData icon;
  final String name;
  const TabWidget({
    super.key,
    required this.icon,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: Theme.of(context).focusColor),
        const SizedBox(width: 3),
        Text(
          name,
          style: TextStyle(
            color: Theme.of(context).focusColor,
          ),
        ),
      ],
    );
  }
}
