import 'package:flutter/material.dart';

class UpdateTxtFieldWidget extends StatefulWidget {
  final String? value;
  final IconData? icon;
  final bool? isPassword;
  final int? maxLine;
  final TextInputType textInputType;
  final ValueChanged<String> onChanged;
  const UpdateTxtFieldWidget({
    super.key,
    this.value,
    this.icon,
    this.isPassword,
    required this.textInputType,
    required this.onChanged,
    this.maxLine,
  });

  @override
  State<UpdateTxtFieldWidget> createState() => _UpdateTxtFieldWidgetState();
}

class _UpdateTxtFieldWidgetState extends State<UpdateTxtFieldWidget> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.value);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: widget.textInputType,
      controller: _controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: Theme.of(context).primaryColor,
        prefixIcon: widget.icon != null
            ? Icon(
                widget.icon,
                color: Colors.grey,
              )
            : null,
        contentPadding: const EdgeInsets.all(10.0),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      maxLines: widget.maxLine ?? 1,
      onChanged: widget.onChanged,
      obscureText: widget.isPassword ?? false,
    );
  }
}
