import 'package:flutter/material.dart';
import 'package:sudanese_job_finder/constant/app_color.dart';
import 'package:sudanese_job_finder/model/job_application_seeker_detail_response.dart';
import 'package:sudanese_job_finder/view/job_seeker/show_attachment_screen.dart';
import 'package:sudanese_job_finder/widget/global/app_bar_widget.dart';
import 'package:sudanese_job_finder/widget/global/non_scrollable_list_view_widget.dart';
import 'package:sudanese_job_finder/widget/global/txt_btn_widget.dart';

class AttachmentScreen extends StatelessWidget {
  final JobApplicationSeekerDetailResponse data;
  const AttachmentScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(isHome: false, title: 'Attachment'),
      body: SingleChildScrollView(
        child: NonScrollableListViewWidget(
          itemCount: data.jobSeekerAttachment!.length,
          itemBuilder: (BuildContext context, index) {
            return Container(
              width: double.infinity,
              margin: const EdgeInsets.all(15),
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 3),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).cardColor,
                boxShadow: AppColor.shadow,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.jobSeekerAttachment?[index].jobSeekerAttachmentType ??
                        '',
                    style: const TextStyle(
                      color: AppColor.appPrimaryColor,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TxtBtnWidget(
                        voidCallback: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ShowAttachmentScreen(
                                base64String:
                                    data.jobSeekerAttachment?[index].fileData,
                              ),
                            ),
                          );
                        },
                        btnName: 'Show',
                      )
                    ],
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
