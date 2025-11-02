import 'package:flutter/material.dart';
import 'package:sudanese_job_finder/constant/app_color.dart';
import 'package:sudanese_job_finder/widget/global/row_txt_widget.dart';

class JobSeekerProfessionalCardWidget extends StatelessWidget {
  final String type;
  final String mark;
  final String examDate;
  final VoidCallback voidCallbackDelete;
  final VoidCallback voidCallbackUpdate;
  const JobSeekerProfessionalCardWidget({
    super.key,
    required this.voidCallbackDelete,
    required this.voidCallbackUpdate,
    required this.type,
    required this.mark,
    required this.examDate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(10, 15, 10, 0),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        boxShadow: AppColor.shadow,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 0),
            child: Text(
              type,
              style: const TextStyle(
                color: AppColor.appPrimaryColor,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          RowTxtWidget(title: 'mark', content: mark),
          RowTxtWidget(title: 'Exam Date', content: examDate),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: voidCallbackUpdate,
                child: const Text(
                  'Update',
                  style: TextStyle(
                    color: AppColor.appPrimaryColor,
                  ),
                ),
              ),
              TextButton(
                onPressed: voidCallbackDelete,
                child: const Text(
                  'Delete',
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
