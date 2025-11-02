import 'package:flutter/material.dart';

class RadioButtonWidget extends StatefulWidget {
  final String? selectedValue; // Currently selected value
  final List<String> options; // List of radio button options
  final ValueChanged<String>
      onChanged; // Callback for when a radio button is selected

  const RadioButtonWidget({
    super.key,
    this.selectedValue,
    required this.options,
    required this.onChanged,
  });

  @override
  State<RadioButtonWidget> createState() => _RadioButtonWidgetState();
}

class _RadioButtonWidgetState extends State<RadioButtonWidget> {
  String? _selectedValue; // Local state to track the selected radio button

  @override
  void initState() {
    super.initState();
    // Initialize the selected value with the provided value (if any)
    _selectedValue = widget.selectedValue;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widget.options.map((option) {
        return RadioListTile<String>(
          title: Text(option),
          value: option,
          groupValue: _selectedValue,
          onChanged: (value) {
            setState(() {
              _selectedValue = value; // Update the selected value
            });
            widget.onChanged(value!); // Notify the parent widget
          },
        );
      }).toList(),
    );
  }
}
