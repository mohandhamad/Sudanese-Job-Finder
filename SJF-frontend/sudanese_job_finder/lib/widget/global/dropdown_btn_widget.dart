import 'package:flutter/material.dart';

class DropdownButtonWidget extends StatelessWidget {
  final String? selectedValue;
  final String labelText;
  final String mapValue;
  final String mapText;
  final List listData;
  final ValueChanged<String?> onChanged;
  const DropdownButtonWidget({
    super.key,
    required this.onChanged,
    this.selectedValue,
    required this.labelText,
    required this.mapValue,
    required this.mapText,
    required this.listData,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      key: ValueKey(listData.length),
      value: listData.isEmpty ||
              !listData.any((e) => e[mapValue].toString() == selectedValue)
          ? null
          : selectedValue,
      style: const TextStyle(fontSize: 15, color: Colors.black),
      decoration: InputDecoration(
        filled: true,
        fillColor: Theme.of(context).primaryColor,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(10),
        ),
        label: Text(labelText),
        labelStyle: const TextStyle(color: Colors.grey),
      ),
      items: [
        ...listData.map((e) {
          return DropdownMenuItem<String>(
            value: e[mapValue].toString(),
            child: Text(
              e[mapText],
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Theme.of(context).focusColor),
            ),
          );
        }),
      ],
      onChanged: onChanged,
      isExpanded: true,
    );
  }
}
