import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sudanese_job_finder/constant/app_color.dart';

class DateFieldWidget extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final DateTime? now;
  const DateFieldWidget({
    super.key,
    required this.controller,
    required this.labelText, this.now,
  });

  @override
  State<DateFieldWidget> createState() => _DateFieldWidgetState();
}

class _DateFieldWidgetState extends State<DateFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      keyboardType: TextInputType.none,
      decoration: InputDecoration(
        filled: true,
        fillColor: Theme.of(context).primaryColor,
        prefixIcon: const Icon(
          Icons.calendar_today_rounded,
          color: Colors.grey,
        ),
        labelText: widget.labelText,
        labelStyle: const TextStyle(color: Colors.grey),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onTap: () async {
        DateTime? pickeddate = await showDatePicker(
          context: context,
          initialDate: widget.now ?? DateTime.now(),
          firstDate: DateTime(1960),
          lastDate: DateTime(2100),
          builder: (BuildContext context, Widget? child) {
            return Theme(
              data: ThemeData.light().copyWith(
                colorScheme: const ColorScheme.light(
                  primary: AppColor.appPrimaryColor,
                  // onSurface: Theme.of(context).focusColor,
                ),
                dialogBackgroundColor: Theme.of(context).cardColor,
              ),
              child: child!,
            );
          },
        );
        if (pickeddate != null) {
          setState(() {
            widget.controller.text =
                DateFormat('yyyy-MM-dd').format(pickeddate);
          });
        }
      },
    );
  }
}
