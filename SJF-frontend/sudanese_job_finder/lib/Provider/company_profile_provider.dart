import 'package:flutter/material.dart';
import 'package:sudanese_job_finder/model/company_profile_response.dart';
import 'package:sudanese_job_finder/services/company_services.dart';
import 'package:sudanese_job_finder/util/token_decode.dart';

class CompanyProfileProvider extends ChangeNotifier {
  final _api = CompanyServices();
  final _token = TokenDecode();
  bool isLoading = false;

  List<CompanyProfileResponse> _companyProfileList = [];
  List<CompanyProfileResponse> get companyProfileList => _companyProfileList;

  Future<void> getCompanyProfile() async {
    isLoading = true;
    notifyListeners();
    final temp = await _token.getUserID();
    final response = await _api.getProfile(temp);
    _companyProfileList = response;
    isLoading = false;
    notifyListeners();
  }
}
