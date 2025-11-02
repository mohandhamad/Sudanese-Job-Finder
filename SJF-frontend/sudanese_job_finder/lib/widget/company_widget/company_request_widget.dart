import 'package:flutter/material.dart';
import 'package:sudanese_job_finder/constant/app_color.dart';
import 'package:sudanese_job_finder/widget/global/row_txt_widget.dart';
import 'package:sudanese_job_finder/widget/global/txt_btn_widget.dart';

class CompanyRequestWidget extends StatelessWidget {
  final String jobName;
  final String jobSeekerName;
  final String status;
  final VoidCallback voidCallbackDetail;
  final VoidCallback voidCallbackUpdate;
  const CompanyRequestWidget({
    super.key,
    required this.jobName,
    required this.jobSeekerName,
    required this.status,
    required this.voidCallbackUpdate,
    required this.voidCallbackDetail,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      child: Column(
        children: [
          const SizedBox(height: 8),
          ListTile(
            title: Text(
              jobName,
              style: const TextStyle(
                color: AppColor.appPrimaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            trailing: ElevatedButton(
              onPressed: voidCallbackDetail,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColor.appBtnColor,
              ),
              child: const Text(
                'Detail',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          const Divider(),
          RowTxtWidget(title: 'Name', content: jobSeekerName),
          RowTxtWidget(title: 'Status', content: status),
          ButtonBar(
            alignment: MainAxisAlignment.end,
            children: [
              TxtBtnWidget(
                color: AppColor.appPrimaryColor,
                voidCallback: voidCallbackUpdate,
                btnName: 'Update Status',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
