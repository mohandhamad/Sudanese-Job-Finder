import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sudanese_job_finder/Provider/account_data_provider.dart';
import 'package:sudanese_job_finder/Provider/company_profile_provider.dart';
import 'package:sudanese_job_finder/Provider/job_seeker_profile_provider.dart';
import 'package:sudanese_job_finder/constant/app_color.dart';
import 'package:sudanese_job_finder/constant/app_route.dart';
import 'package:sudanese_job_finder/constant/app_strings.dart';
import 'package:sudanese_job_finder/model/account_data_response.dart';
import 'package:sudanese_job_finder/model/company_profile_response.dart';
import 'package:sudanese_job_finder/model/job_seeker_profile_response.dart';
import 'package:sudanese_job_finder/services/company_services.dart';
import 'package:sudanese_job_finder/services/noti_services.dart';
import 'package:sudanese_job_finder/util/dialog.dart';
import 'package:sudanese_job_finder/util/secure_storage.dart';

class TempScreen extends StatefulWidget {
  const TempScreen({super.key});

  @override
  State<TempScreen> createState() => _TempScreenState();
}

class _TempScreenState extends State<TempScreen> {
  bool isLoading = false;
  final _api = CompanyServices();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      NotiService().initNotifications(); // Initialize notifications
      fetchData();
    });
  }

  Future<void> fetchData() async {
    setState(() => isLoading = true);
    final accountDataProvider =
        Provider.of<AccountDataProvider>(context, listen: false);
    accountDataProvider.getAccountData().then((_) {
      List<AccountDataResponse> accountData = [];
      accountData = accountDataProvider.accountDataList;
      if (accountData.isNotEmpty && accountData[0].groups!.contains(4)) {
        getJobSeekerProfile();
      } else if (accountData.isNotEmpty && accountData[0].groups!.contains(2)) {
        getCompanyProfile();
      } else {
        retry();
      }
    });
  }

  void getCompanyProfile() {
    final companyProfile =
        Provider.of<CompanyProfileProvider>(context, listen: false);
    List<CompanyProfileResponse> profileData = [];
    companyProfile.getCompanyProfile().then((_) {
      profileData = companyProfile.companyProfileList;
      if (profileData.isNotEmpty) {
        GoRouter.of(context)
            .pushReplacementNamed(AppRoute.homeCompanyRouteName);
        if (mounted) setState(() => isLoading = false);
      } else {
        errorDialog(
          context: context,
          errorTitle: "Error",
          errorDescription: "Error fetching data",
          btnTitle: "Retry",
          voidCallback: () => getCompanyProfile(),
          btnCancelTitle: "Cancel",
          voidCallbackCancel: () => logout(),
        );
      }
    });
  }

  void getJobSeekerProfile() {
    final jobSeekerProfile =
        Provider.of<JobSeekerProfileProvider>(context, listen: false);
    List<JobSeekerProfileResponse> profileData = [];
    jobSeekerProfile.getJobSeekerProfile().then((_) async {
      profileData = jobSeekerProfile.jobSeekerProfileList;
      if (profileData.isNotEmpty) {
        // Fetch recommended jobs
        final id = profileData[0].id;
        final recommendedJobs = await _api.getRecommedJob(id!);

        // Send notification if recommended jobs are available
        if (recommendedJobs.isNotEmpty) {
          final random = Random();
          final rJob = recommendedJobs[random.nextInt(recommendedJobs.length)];
          print('RecoJob is ${rJob.jobTitle}');
          // final firstJob = recommendedJobs[0];
          NotiService().showNotification(
            title: "Recommended Job for You!",
            body:
                "${rJob.jobTitle} at ${rJob.companyProfile?.companyName ?? 'a company'}",
          );
        }

        // Navigate to the jobseeker home screen
        GoRouter.of(context)
            .pushReplacementNamed(AppRoute.homeJobSeekerRouteName);
        if (mounted) setState(() => isLoading = false);
      } else {
        errorDialog(
          context: context,
          errorTitle: "Error",
          errorDescription: "Error fetching data",
          btnTitle: "Retry",
          voidCallback: () => getJobSeekerProfile(),
          btnCancelTitle: "Cancel",
          voidCallbackCancel: () => logout(),
        );
      }
    });
  }

  void retry() {
    errorDialog(
      context: context,
      errorTitle: "Error",
      errorDescription: "Error fetching data",
      btnTitle: "Retry",
      voidCallback: () => fetchData(),
      btnCancelTitle: "Cancel",
      voidCallbackCancel: () => logout(),
    );
  }

  void logout() {
    SecureStorage.deleteSecureData(AppStrings.accessTokenKey);
    SecureStorage.deleteSecureData(AppStrings.refreshTokenKey);
    GoRouter.of(context).pushReplacementNamed(AppRoute.onboardingRouteName);
    if (mounted) setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (letsFuckingGo) async {
        fetchData();
        letsFuckingGo = true;
      },
      child: Scaffold(
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(
                  color: AppColor.appPrimaryColor,
                ),
              )
            : const SizedBox.shrink(),
      ),
    );
  }
}
