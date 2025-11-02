import 'package:flutter/material.dart';
import 'package:sudanese_job_finder/constant/app_color.dart';
import 'package:sudanese_job_finder/widget/global/row_txt_widget.dart';

class JobSeekerQualificationCardWidget extends StatelessWidget {
  final String major;
  final String org;
  final String degree;
  final String grade;
  final VoidCallback voidCallbackUpdate;
  final VoidCallback voidCallbackDelete;
  const JobSeekerQualificationCardWidget({
    super.key,
    required this.major,
    required this.org,
    required this.degree,
    required this.grade,
    required this.voidCallbackUpdate,
    required this.voidCallbackDelete,
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
              major,
              style: const TextStyle(
                color: AppColor.appPrimaryColor,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          RowTxtWidget(title: 'EDU-ORG', content: org),
          RowTxtWidget(title: 'Degree', content: degree),
          RowTxtWidget(title: 'Grade', content: grade),
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
