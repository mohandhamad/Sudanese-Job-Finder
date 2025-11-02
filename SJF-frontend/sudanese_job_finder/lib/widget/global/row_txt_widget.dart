import 'package:flutter/material.dart';

class RowTxtWidget extends StatelessWidget {
  final String title;
  final String content;
  final Color? color;
  final double? padding;
  const RowTxtWidget({
    super.key,
    required this.title,
    required this.content,
    this.padding, this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: padding ?? 16,
        vertical: padding ?? 8,
      ),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: color,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              content,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: color,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
