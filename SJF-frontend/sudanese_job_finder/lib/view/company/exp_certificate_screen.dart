import 'package:flutter/material.dart';
import 'package:sudanese_job_finder/constant/app_color.dart';
import 'package:sudanese_job_finder/model/job_application_seeker_detail_response.dart';
import 'package:sudanese_job_finder/widget/global/app_bar_widget.dart';
import 'package:sudanese_job_finder/widget/global/non_scrollable_list_view_widget.dart';
import 'package:sudanese_job_finder/widget/global/row_txt_widget.dart';

class ExpCertificateScreen extends StatelessWidget {
  final JobApplicationSeekerDetailResponse data;
  const ExpCertificateScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          const AppBarWidget(isHome: false, title: 'Experience Certificate'),
      body: SingleChildScrollView(
        child: NonScrollableListViewWidget(
          itemCount: data.jobSeekerExperienceCertificate!.length,
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.jobSeekerExperienceCertificate?[index]
                            .experienceRole ??
                        '',
                    style: const TextStyle(
                      color: AppColor.appPrimaryColor,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  RowTxtWidget(
                    title: 'Start Date',
                    content: data
                            .jobSeekerExperienceCertificate?[index].startDate
                            .toString() ??
                        '',
                  ),
                  RowTxtWidget(
                    title: 'End Date',
                    content: data.jobSeekerExperienceCertificate?[index].endDate
                            .toString() ??
                        '',
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(15,0,0,0),
                    child: Text('Job Duties:'),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15,0,0,0),
                    child: Text(
                      data.jobSeekerExperienceCertificate![index].jobDuties ?? '',
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(15,0,0,0),
                    child: Text('Implemented Projects:'),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15,0,0,0),
                    child: Text(
                      data.jobSeekerExperienceCertificate![index]
                              .implementedProjects ??
                          '',
                    ),
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
