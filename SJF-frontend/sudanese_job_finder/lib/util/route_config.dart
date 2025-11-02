import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:sudanese_job_finder/auth/set_new_password.dart';
import 'package:sudanese_job_finder/settings/temp_screen.dart';
import 'package:sudanese_job_finder/auth/login_screen.dart';
import 'package:sudanese_job_finder/auth/onboarding_screen.dart';
import 'package:sudanese_job_finder/auth/register_screen.dart';
import 'package:sudanese_job_finder/auth/reset_password_screen.dart';
//import 'package:sudanese_job_finder/auth/verify_screen.dart';
//import 'package:sudanese_job_finder/auth/user_type_screen.dart';
import 'package:sudanese_job_finder/constant/app_route.dart';
import 'package:sudanese_job_finder/constant/app_strings.dart';
import 'package:sudanese_job_finder/settings/email_verify_error.dart';
import 'package:sudanese_job_finder/settings/email_verify_success.dart';
import 'package:sudanese_job_finder/settings/reset_password_token_expired.dart';
import 'package:sudanese_job_finder/util/secure_storage.dart';
import 'package:sudanese_job_finder/view/company/company_gallery_screen.dart';
import 'package:sudanese_job_finder/view/company/company_home_screen.dart';
import 'package:sudanese_job_finder/view/company/company_job_screen.dart';
import 'package:sudanese_job_finder/view/company/company_menu_screen.dart';
import 'package:sudanese_job_finder/view/company/company_profile_screen.dart';
//import 'package:sudanese_job_finder/view/job_seeker/job_seeker_fillter_screen.dart';
import 'package:sudanese_job_finder/view/job_seeker/job_seeker_home_screen.dart';
import 'package:sudanese_job_finder/view/job_seeker/job_seeker_job_application_screen.dart';
//import 'package:sudanese_job_finder/view/job_seeker/job_seeker_job_screen.dart';
import 'package:sudanese_job_finder/view/job_seeker/job_seeker_menu_screen.dart';
import 'package:sudanese_job_finder/view/job_seeker/job_seeker_tabs_widget.dart';
import 'package:sudanese_job_finder/view/job_seeker/show_attachment_screen.dart';
import 'package:sudanese_job_finder/widget/global/side_nav_widget.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class RouteConfig {
  static bool hasRedirectExecuted = false;
  final router = GoRouter(
    initialLocation: '/',
    navigatorKey: navigatorKey,
    routes: [
      GoRoute(
        parentNavigatorKey: navigatorKey,
        name: AppRoute.onboardingRouteName,
        path: '/',
        pageBuilder: (context, state) {
          return const MaterialPage(
            child: OnboardingScreen(),
          );
        },
      ),
      GoRoute(
        name: AppRoute.loginRouteName,
        path: '/login',
        pageBuilder: (context, state) {
          return const MaterialPage(
            child: LoginScreen(),
          );
        },
      ),
      GoRoute(
        name: AppRoute.tempRouteName,
        path: '/temp',
        pageBuilder: (context, state) {
          return const MaterialPage(
            child: TempScreen(),
          );
        },
      ),
      GoRoute(
        name: AppRoute.registerRouteName,
        path: '/register',
        pageBuilder: (context, state) {
          return const MaterialPage(
            child: RegisterScreen(),
          );
        },
      ),
      //GoRoute(
        //name: AppRoute.emailVerifyRouteName,
        //path: '/email-verify',
        //pageBuilder: (context, state) {
          //return const MaterialPage(
            //child: VerifyScreen(),
          //);
        //},
      //),
      GoRoute(
        name: AppRoute.emailVerifyErrorRouteName,
        path: '/email-verify-error',
        pageBuilder: (context, state) {
          return const MaterialPage(
            child: EmailVerifyError(),
          );
        },
      ),
      GoRoute(
        name: AppRoute.emailVerifySuccessRouteName,
        path: '/email-verify-success',
        pageBuilder: (context, state) {
          return const MaterialPage(
            child: EmailVerifySuccess(),
          );
        },
      ),
      GoRoute(
        name: AppRoute.resetPasswordRouteName,
        path: '/reset-password',
        pageBuilder: (context, state) {
          return const MaterialPage(
            child: ResetPasswordScreen(),
          );
        },
      ),
      GoRoute(
        name: AppRoute.setNewPasswordRouteName,
        path: '/set-new-password/:uidb64/:token',
        pageBuilder: (context, state) {
          return MaterialPage(
            child: SetNewPassword(
              uidb64: state.pathParameters['uidb64'],
              token: state.pathParameters['token'],
            ),
          );
        },
      ),
      GoRoute(
        name: AppRoute.resetPasswordTokenExpiredRouteName,
        path: '/reset-password-token-expired',
        pageBuilder: (context, state) {
          return const MaterialPage(
            child: ResetPasswordTokenExpired(),
          );
        },
      ),
      GoRoute(
        name: AppRoute.homeCompanyRouteName,
        path: '/home-company',
        pageBuilder: (context, state) {
          return MaterialPage(
            child: SideNavWidget(
              mainScreen: const CompanyHomeScreen(),
              menuScreen: const CompanyMenuScreen(),
            ),
          );
        },
        routes: [
          GoRoute(
            name: AppRoute.companyProfileRouteName,
            path: 'company-profile',
            pageBuilder: (context, state) {
              return const MaterialPage(
                child: CompanyProfileScreen(),
              );
            },
            routes: [
              GoRoute(
                name: AppRoute.companyGalleryRouteName,
                path: 'gallery',
                pageBuilder: (context, state) {
                  return const MaterialPage(
                    child: CompanyGalleryScreen(),
                  );
                },
              ),
            ],
          ),
          GoRoute(
            name: AppRoute.companyJobRouteName,
            path: 'company-job',
            pageBuilder: (context, state) {
              return const MaterialPage(
                child: CompanyJobScreen(),
              );
            },
          ),
        ],
      ),
      GoRoute(
        name: AppRoute.homeJobSeekerRouteName,
        path: '/home-job-seeker',
        pageBuilder: (context, state) {
          return MaterialPage(
            child: SideNavWidget(
              mainScreen: const JobSeekerHomeScreen(),
              menuScreen: const JobSeekerMenuScreen(),
            ),
          );
        },
        routes: [
          GoRoute(
            name: AppRoute.jobSeekerProfileRouteName,
            path: 'job-seeker-profile',
            pageBuilder: (context, state) {
              return const MaterialPage(
                child: JobSeekerTabsWidget(),
              );
            },
            routes: [
              GoRoute(
                name: AppRoute.showPDFRouteName,
                path: 'show-pdf/:base64String',
                pageBuilder: (context, state) {
                  return MaterialPage(
                    child: ShowAttachmentScreen(
                      base64String: state.pathParameters['base64String'],
                    ),
                  );
                },
              ),
            ],
          ),
          /*GoRoute(
            name: AppRoute.jobSeekerfillterRouteName,
            path: 'fillter',
            pageBuilder: (context, state) {
              return const MaterialPage(
                child: JobSeekerFillterScreen(),
              );
            },
            routes: [
              GoRoute(
                name: AppRoute.jobSeekerJobRouteName,
                path: 'jobs/:isRecommended',
                pageBuilder: (context, state) {
                  return MaterialPage(
                    child: JobSeekerJobScreen(
                      isRecommended: state.pathParameters['isRecommended']!,
                    ),
                  );
                },
              ),
            ],
          ),*/
          GoRoute(
            name: AppRoute.jobSeekerJobApplication,
            path: 'job-application',
            pageBuilder: (context, state) {
              return const MaterialPage(
                child: JobSeekerJobApplicationScreen(),
              );
            },
          ),
        ],
      ),
    ],
    // errorPageBuilder: ((context, state) {
    //   return const MaterialPage(child: ErrorScreen());
    // }),
    redirect: (context, state) async {
      if (!hasRedirectExecuted) {
        final refresh =
            await SecureStorage.readSecureData(AppStrings.refreshTokenKey);
        if (refresh != null && !JwtDecoder.isExpired(refresh)) {
          hasRedirectExecuted = true;
          return '/temp';
        }
      }
      return null;
    },
  );
}
