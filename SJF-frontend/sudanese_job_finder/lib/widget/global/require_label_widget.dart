import 'package:flutter/material.dart';

class RequireLabelWidget extends StatelessWidget {
  final String label;
  final bool isNotFill;
  const RequireLabelWidget({
    super.key,
    required this.label,
    required this.isNotFill,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(label),
        isNotFill ? const Text(
          '*',
          style: TextStyle(
            color: Colors.red,
          ),
        ) : const SizedBox.shrink()
      ],
    );
  }
}
