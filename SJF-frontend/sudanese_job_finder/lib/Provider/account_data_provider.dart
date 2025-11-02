import 'package:flutter/material.dart';
import 'package:sudanese_job_finder/model/account_data_response.dart';
import 'package:sudanese_job_finder/services/company_services.dart';
import 'package:sudanese_job_finder/util/token_decode.dart';

class AccountDataProvider extends ChangeNotifier {
  final _api = CompanyServices();
  final _token = TokenDecode();
  bool isLoading = false;

  List<AccountDataResponse> _accountDataList = [];
  List<AccountDataResponse> get accountDataList => _accountDataList;

  Future<void> getAccountData() async {
    isLoading = true;
    notifyListeners();
    final temp = await _token.getUserID();
    final response = await _api.getAccountData(temp);
    _accountDataList = response;
    isLoading = false;
    notifyListeners();
  }
}
