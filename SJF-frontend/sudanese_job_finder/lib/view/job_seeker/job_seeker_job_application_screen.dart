import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sudanese_job_finder/Provider/job_seeker_profile_provider.dart';
import 'package:sudanese_job_finder/constant/app_color.dart';
import 'package:sudanese_job_finder/constant/app_strings.dart';
import 'package:sudanese_job_finder/model/job_seeker_job_application_detail_response.dart';
import 'package:sudanese_job_finder/services/job_seeker_services.dart';
import 'package:sudanese_job_finder/util/toast.dart';
import 'package:sudanese_job_finder/view/job_seeker/job_seeker_job_application_detail_screen.dart';
import 'package:sudanese_job_finder/widget/global/app_bar_widget.dart';
import 'package:sudanese_job_finder/widget/global/non_scrollable_list_view_widget.dart';
import 'package:sudanese_job_finder/widget/job_seeker_widget/job_seeker_j_p_application_card_widget.dart';

class JobSeekerJobApplicationScreen extends StatefulWidget {
  const JobSeekerJobApplicationScreen({super.key});

  @override
  State<JobSeekerJobApplicationScreen> createState() =>
      _JobSeekerJobApplicationScreenState();
}

class _JobSeekerJobApplicationScreenState
    extends State<JobSeekerJobApplicationScreen> {
  final _api = JobSeekerServices();
  bool isLoading = false;

  Future<List<JobSeekerJobApplicationDetailResponse>> fetchData() async {
    final id = Provider.of<JobSeekerProfileProvider>(context, listen: false)
        .jobSeekerProfileList[0]
        .id;
    final response = _api.getJobApplicationDetail(id!);
    return response;
  }

  void deleteRequest(int id) {
    setState(() => isLoading = true);
    _api.deleteJobApplication(id).then((response) {
      if (response) {
        successToast('Delete successfuily.');
      } else {
        errorToast('Error, Plz try again');
      }
    });
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(
        isHome: false,
        title: 'Job Requests',
      ),
      body: FutureBuilder(
        future: fetchData(),
        builder: (
          BuildContext context,
          AsyncSnapshot<List<JobSeekerJobApplicationDetailResponse>> snapshot,
        ) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColor.appPrimaryColor,
              ),
            );
          } else if (snapshot.hasError) {
            return Center(child: Image.asset(AppStrings.appError));
          } else {
            final data = snapshot.data!;
            if (isLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  color: AppColor.appPrimaryColor,
                ),
              );
            }
            return _body(context, data);
          }
        },
      ),
    );
  }

  SingleChildScrollView _body(
      BuildContext context, List<JobSeekerJobApplicationDetailResponse> data) {
    return SingleChildScrollView(
      child: NonScrollableListViewWidget(
        itemCount: data.length,
        itemBuilder: (BuildContext context, index) {
          return JobSeekerJPApplicationCardWidget(
            title: data[index].companyJob?.jobTitle ?? '',
            supTitle: data[index].companyProfile?.companyName ?? '',
            status: data[index].applicationStatus?.description ?? '',
            voidCallbackInfo: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => JobSeekerJobApplicationDetailScreen(
                    data: data[index],
                  ),
                ),
              );
            },
            voidCallbackDelete: () {
              deleteRequest(data[index].id!);
            },
          );
        },
      ),
    );
  }
}
