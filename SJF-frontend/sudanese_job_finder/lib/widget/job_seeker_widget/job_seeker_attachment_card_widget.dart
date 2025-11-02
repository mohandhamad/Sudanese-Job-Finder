import 'package:flutter/material.dart';
import 'package:sudanese_job_finder/constant/app_color.dart';

class JobSeekerAttachmentCardWidget extends StatelessWidget {
  final String content;
  final VoidCallback voidCallbackDelete;
  final VoidCallback voidCallbackShow;
  const JobSeekerAttachmentCardWidget({
    super.key,
    required this.content,
    required this.voidCallbackDelete,
    required this.voidCallbackShow,
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
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: Text(
              content,
              style: const TextStyle(
                color: AppColor.appPrimaryColor,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: voidCallbackShow,
                child: const Text(
                  'Show',
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