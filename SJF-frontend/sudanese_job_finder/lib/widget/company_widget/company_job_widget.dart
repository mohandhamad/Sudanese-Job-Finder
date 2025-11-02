import 'package:flutter/material.dart';
import 'package:sudanese_job_finder/constant/app_color.dart';
import 'package:sudanese_job_finder/widget/global/row_txt_widget.dart';

class CompanyJobWidget extends StatelessWidget {
  final String jobTitle;
  final String deadline;
  final String salary;
  final VoidCallback voidCallbackDelete;
  final VoidCallback voidCallbackUpdate;
  const CompanyJobWidget({
    super.key,
    required this.voidCallbackDelete,
    required this.voidCallbackUpdate,
    required this.jobTitle,
    required this.deadline,
    required this.salary,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(15),
          boxShadow: AppColor.shadow,
        ),
        child: Column(
          children: [
            ListTile(
              title: Text(
                jobTitle,
                style: const TextStyle(
                    color: AppColor.appPrimaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(16.0, 0, 16, 0),
              child: Divider(),
            ),
            RowTxtWidget(
              title: 'Deadline:',
              content: deadline,
            ),
            RowTxtWidget(
              title: 'Salary:',
              content: "$salary \$",
            ),
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
      ),
    );
  }
}
