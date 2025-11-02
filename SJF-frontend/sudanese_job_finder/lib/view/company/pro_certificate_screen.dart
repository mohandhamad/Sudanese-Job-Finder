import 'package:flutter/material.dart';
import 'package:sudanese_job_finder/constant/app_color.dart';
import 'package:sudanese_job_finder/model/job_application_seeker_detail_response.dart';
import 'package:sudanese_job_finder/widget/global/app_bar_widget.dart';
import 'package:sudanese_job_finder/widget/global/non_scrollable_list_view_widget.dart';
import 'package:sudanese_job_finder/widget/global/row_txt_widget.dart';

class ProCertificateScreen extends StatelessWidget {
  final JobApplicationSeekerDetailResponse data;
  const ProCertificateScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          const AppBarWidget(isHome: false, title: 'Professional Certificate'),
      body: SingleChildScrollView(
        child: NonScrollableListViewWidget(
            itemCount: data.jobSeekerProfessionalCertificate!.length,
            itemBuilder: (BuildContext context, index) {
              return Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.fromLTRB(10, 15, 10, 0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).cardColor,
                  boxShadow: AppColor.shadow,
                ),
                child: Column(
                  children: [
                    RowTxtWidget(
                      title: 'Type',
                      content:
                          data.jobSeekerProfessionalCertificate?[index].type ??
                              '',
                    ),
                    RowTxtWidget(
                      title: 'Mark',
                      content:
                          data.jobSeekerProfessionalCertificate?[index].mark ??
                              '',
                    ),
                    RowTxtWidget(
                      title: 'Exam Date',
                      content: data
                              .jobSeekerProfessionalCertificate?[index].examDate
                              .toString() ??
                          '',
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }
}
