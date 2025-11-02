import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sudanese_job_finder/Provider/account_data_provider.dart';
import 'package:sudanese_job_finder/Provider/company_profile_provider.dart';
import 'package:sudanese_job_finder/Provider/job_seeker_profile_provider.dart';
import 'package:sudanese_job_finder/Provider/theme_provider.dart';
import 'package:sudanese_job_finder/services/noti_services.dart';
import 'package:sudanese_job_finder/util/route_config.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize the notification service
  NotiService().initNotifications();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const SudaneseJobFinder());
}

class SudaneseJobFinder extends StatelessWidget {
  const SudaneseJobFinder({super.key});

  @override
  Widget build(BuildContext context) {
    final RouteConfig appRouterConfig = RouteConfig();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => AccountDataProvider()),
        ChangeNotifierProvider(create: (context) => CompanyProfileProvider()),
        ChangeNotifierProvider(create: (context) => JobSeekerProfileProvider())
      ],
      builder: (context, _) {
        final themeProvider = Provider.of<ThemeProvider>(context);
        return MaterialApp.router(
          title: 'Sudanese Job Finder',
          debugShowCheckedModeBanner: false,
          themeMode: themeProvider.themeMode,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          routerConfig: appRouterConfig.router,
        );
      },
    );
  }
}
