import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sudanese_job_finder/Provider/account_data_provider.dart';
import 'package:sudanese_job_finder/Provider/company_profile_provider.dart';
import 'package:sudanese_job_finder/constant/app_route.dart';
import 'package:sudanese_job_finder/constant/app_strings.dart';
import 'package:sudanese_job_finder/settings/settings_screen.dart';
import 'package:sudanese_job_finder/util/secure_storage.dart';
import 'package:sudanese_job_finder/view/company/analytics_screen.dart';
import 'package:sudanese_job_finder/view/company/company_request_job_screen.dart';
import 'package:sudanese_job_finder/widget/global/side_nav_header_widget.dart';
import 'package:sudanese_job_finder/widget/global/side_nav_item_widget.dart';
import 'package:sudanese_job_finder/view/company/company_interview_schedule_screen.dart';

class CompanyMenuScreen extends StatelessWidget {
  const CompanyMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final accountData =
        Provider.of<AccountDataProvider>(context).accountDataList;
    final profileData =
        Provider.of<CompanyProfileProvider>(context).companyProfileList;
    return Scaffold(
      backgroundColor: Colors.indigo,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
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
                    .pushNamed(AppRoute.companyProfileRouteName);
              },
            ),
            SideNavItemWidget(
              icon: Icons.wysiwyg,
              title: 'Jobs',
              voidCallback: () {
                GoRouter.of(context).pushNamed(AppRoute.companyJobRouteName);
              },
            ),
            // SideNavItemWidget(
            //   icon: Icons.wysiwyg,
            //   title: 'Available Job',
            //   voidCallback: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //         builder: (context) => const CompanyAvailableJobScreen(),
            //       ),
            //     );
            //   },
            // ),
            SideNavItemWidget(
              icon: Icons.contact_page,
              title: 'Requests',
              voidCallback: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CompanyRequestJobScreen(),
                  ),
                );
              },
            ),
            SideNavItemWidget(
              icon: Icons.schedule,
              title: 'Schedule Interviews',
              voidCallback: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const CompanyInterviewScheduleScreen(),
                  ),
                );
              },
            ),
            SideNavItemWidget(
              icon: Icons.analytics,
              title: 'Analytics',
              voidCallback: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AnalyticsScreen(),
                  ),
                );
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
