import 'package:flutter/material.dart';
import 'package:sudanese_job_finder/constant/app_color.dart';
import 'package:sudanese_job_finder/model/job_application_seeker_detail_response.dart';
import 'package:sudanese_job_finder/widget/global/app_bar_widget.dart';
import 'package:sudanese_job_finder/widget/global/non_scrollable_list_view_widget.dart';
import 'package:sudanese_job_finder/widget/global/row_txt_widget.dart';

class AcaQualificationScreen extends StatelessWidget {
  final JobApplicationSeekerDetailResponse data;
  const AcaQualificationScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          const AppBarWidget(isHome: false, title: 'Academic Qualification'),
      body: SingleChildScrollView(
        child: NonScrollableListViewWidget(
            itemCount: data.jobSeekerAcademicQualifications!.length,
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
                      title: 'Degree',
                      content:
                          data.jobSeekerAcademicQualifications?[index].degree ??
                              '',
                    ),
                    RowTxtWidget(
                      title: 'Major',
                      content:
                          data.jobSeekerAcademicQualifications?[index].major ??
                              '',
                    ),
                    RowTxtWidget(
                      title: 'School',
                      content: data
                              .jobSeekerAcademicQualifications?[index].school
                              .toString() ??
                          '',
                    ),
                    RowTxtWidget(
                      title: 'Graduation',
                      content: data
                              .jobSeekerAcademicQualifications?[index].graduationDate
                              .toString() ??
                          '',
                    ),
                    RowTxtWidget(
                      title: 'GPA',
                      content:
                          data.jobSeekerAcademicQualifications?[index].gpa ??
                              '',
                    ),
                    RowTxtWidget(
                      title: 'Grade',
                      content:
                          data.jobSeekerAcademicQualifications?[index].grade ??
                              '',
                    ),
                    RowTxtWidget(
                      title: 'Start At',
                      content:
                          data.jobSeekerAcademicQualifications?[index].startDate.toString() ??
                              '',
                    ),
                    RowTxtWidget(
                      title: 'End At',
                      content:
                          data.jobSeekerAcademicQualifications?[index].endDate.toString() ??
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