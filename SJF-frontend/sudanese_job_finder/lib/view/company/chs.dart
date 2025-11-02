import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sudanese_job_finder/model/company_profile_response.dart';
import 'package:sudanese_job_finder/services/company_services.dart';
import 'package:sudanese_job_finder/widget/company_widget/company_card_widget.dart';
import 'package:sudanese_job_finder/widget/global/app_bar_widget.dart';
import 'package:sudanese_job_finder/provider/company_profile_provider.dart'; // Ensure this is the correct path

class CompanyHomeScreen extends StatefulWidget {
  const CompanyHomeScreen({super.key});

  @override
  State<CompanyHomeScreen> createState() => _CompanyHomeScreenState();
}

class _CompanyHomeScreenState extends State<CompanyHomeScreen> {
  final _api = CompanyServices();
  late Future<CompanyProfileResponse> _companyProfileFuture;
  late List<CompanyProfileResponse> profiles;
  late Future<CompanyProfileResponse> profile;
  // محاولة لعرض بيانات الشركة في الصفحة الرئيسية

  @override
  void initState() {
    super.initState();
    _companyProfileFuture = getCompanyProfile();
  }

  Future<CompanyProfileResponse> getCompanyProfile() async {
    final id = Provider.of<CompanyProfileProvider>(context, listen: false)
        .companyProfileList[0]
        .id;

    profiles = await _api.getProfile(id!);
    profile = Future.value(profiles.first);
    _companyProfileFuture = profile;
    return _companyProfileFuture;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const AppBarWidget(title: 'Home', isHome: true),
        // body: Placeholder(),
        body: FutureBuilder<CompanyProfileResponse>(
          future: _companyProfileFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              final companyProfile = snapshot.data!;
              return CompanyCardWidget(companyProfile: companyProfile);
            }
          },
        ));
  }
}
