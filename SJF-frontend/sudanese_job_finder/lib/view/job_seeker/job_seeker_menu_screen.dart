import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sudanese_job_finder/Provider/account_data_provider.dart';
import 'package:sudanese_job_finder/Provider/job_seeker_profile_provider.dart';
import 'package:sudanese_job_finder/constant/app_route.dart';
import 'package:sudanese_job_finder/constant/app_strings.dart';
import 'package:sudanese_job_finder/settings/settings_screen.dart';
import 'package:sudanese_job_finder/util/secure_storage.dart';
import 'package:sudanese_job_finder/widget/global/side_nav_header_widget.dart';
import 'package:sudanese_job_finder/widget/global/side_nav_item_widget.dart';

class JobSeekerMenuScreen extends StatelessWidget {
  const JobSeekerMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final accountData =
        Provider.of<AccountDataProvider>(context).accountDataList;
    final profileData =
        Provider.of<JobSeekerProfileProvider>(context).jobSeekerProfileList;
    return Scaffold(
      backgroundColor: Colors.indigo,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            SideNavHeaderWidget(
              image: profileData.isNotEmpty
                  ? profileData[0].image
                  : 'assets/images/default.png',
              username: accountData.isNotEmpty
                  ? (accountData[0].username ?? '-')
                  : '-',
              email:
                  accountData.isNotEmpty ? (accountData[0].email ?? '-') : '-',
            ),
            const Divider(color: Colors.white),
            const SizedBox(height: 20),
            SideNavItemWidget(
              icon: Icons.person,
              title: 'Profile',
              voidCallback: () {
                GoRouter.of(context)
                    .pushNamed(AppRoute.jobSeekerProfileRouteName);
              },
            ),
            SideNavItemWidget(
              icon: Icons.api_sharp,
              title: 'Job Application',
              voidCallback: () {
                GoRouter.of(context)
                    .pushNamed(AppRoute.jobSeekerJobApplication);
              },
            ),
            SideNavItemWidget(
              icon: Icons.settings,
              title: 'Settings',
              voidCallback: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SettingScreen(),
                  ),
                );
              },
            ),
            const Spacer(),
            const Spacer(),
            const Divider(color: Colors.white),
            SideNavItemWidget(
              icon: Icons.logout,
              title: 'Logout',
              voidCallback: () {
                SecureStorage.deleteSecureData(AppStrings.accessTokenKey);
                SecureStorage.deleteSecureData(AppStrings.refreshTokenKey);
                GoRouter.of(context)
                    .pushReplacementNamed(AppRoute.onboardingRouteName);
              },
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
