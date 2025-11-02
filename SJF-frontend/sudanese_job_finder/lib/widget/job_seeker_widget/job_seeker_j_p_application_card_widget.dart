import 'package:flutter/material.dart';
import 'package:sudanese_job_finder/constant/app_color.dart';
import 'package:sudanese_job_finder/widget/global/row_txt_widget.dart';

class JobSeekerJPApplicationCardWidget extends StatelessWidget {
  final String title;
  final String supTitle;
  final String status;
  final VoidCallback voidCallbackInfo;
  final VoidCallback voidCallbackDelete;
  const JobSeekerJPApplicationCardWidget({
    super.key,
    required this.title,
    required this.supTitle,
    required this.status,
    required this.voidCallbackInfo,
    required this.voidCallbackDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(10, 5, 10, 5),
      padding: const EdgeInsets.all(15),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: AppColor.shadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            maxLines: 1,
            style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                overflow: TextOverflow.ellipsis,
                color: AppColor.appPrimaryColor),
          ),
          RowTxtWidget(
            title: 'Role Name',
            content: supTitle,
          ),
          RowTxtWidget(
            title: 'Status',
            content: status,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: voidCallbackInfo,
                child: const Text(
                  'More Information',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColor.appPrimaryColor,
                  ),
                ),
              ),
              TextButton(
                onPressed: voidCallbackDelete,
                child: const Text(
                  'Cencel',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
