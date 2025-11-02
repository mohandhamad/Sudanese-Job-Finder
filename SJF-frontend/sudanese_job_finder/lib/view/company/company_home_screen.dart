import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sudanese_job_finder/model/company_profile_response.dart';
import 'package:sudanese_job_finder/services/company_services.dart';
import 'package:sudanese_job_finder/widget/company_widget/company_card_widget.dart';
import 'package:sudanese_job_finder/widget/global/app_bar_widget.dart';
import 'package:sudanese_job_finder/provider/company_profile_provider.dart';

class CompanyHomeScreen extends StatefulWidget {
  const CompanyHomeScreen({super.key});

  @override
  State<CompanyHomeScreen> createState() => _CompanyHomeScreenState();
}

class _CompanyHomeScreenState extends State<CompanyHomeScreen> {
  final _api = CompanyServices();
  late Future<List<CompanyProfileResponse>>? _companyProfileFuture;
  // محاولة لعرض بيانات الشركة في الصفحة الرئيسية

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AppBarWidget(title: 'Home', isHome: true),
      body: Placeholder(),
      // body: Consumer<CompanyProfileProvider>(
      //   builder: (context, companyProfileProvider, child) {
      //     // Check if the companyProfileList is empty
      //     if (companyProfileProvider.companyProfileList.isEmpty) {
      //       return const Center(child: Text('No company profile available.'));
      //     }

      //     final id = companyProfileProvider.companyProfileList[0].id;

      //     // Make the API call using the id
      //     return FutureBuilder<List<CompanyProfileResponse>>(
      //       future: _api.getProfile(id!),
      //       builder: (context, snapshot) {
      //         if (snapshot.connectionState == ConnectionState.waiting) {
      //           return const Center(child: CircularProgressIndicator());
      //         } else if (snapshot.hasError) {
      //           return Center(child: Text('Error: ${snapshot.error}'));
      //         } else if (snapshot.hasData) {
      //           final companyProfiles = snapshot.data!;
      //           final companyProfile =
      //               companyProfiles.isNotEmpty ? companyProfiles[0] : null;
      //           if (companyProfile != null) {
      //             return CompanyCardWidget(companyProfile: companyProfile);
      //           } else {
      //             return const Center(
      //                 child: Text('No company profile found.'));
      //           }
      //         } else {
      //           return const Center(child: Text('No data available.'));
      //         }
      //       },
      //     );
      //   },
      // )
    );
  }
}
