import 'package:flutter/material.dart';
import 'package:sudanese_job_finder/model/job_seeker_profile_response.dart';
import 'package:sudanese_job_finder/services/job_seeker_services.dart';
import 'package:sudanese_job_finder/util/token_decode.dart';

class JobSeekerProfileProvider extends ChangeNotifier {
  final _api = JobSeekerServices();
  final _token = TokenDecode();
  bool isLoading = false;

  List<JobSeekerProfileResponse> _jobSeekerProfileList = [];
  List<JobSeekerProfileResponse> get jobSeekerProfileList => _jobSeekerProfileList;

  Future<void> getJobSeekerProfile() async {
    isLoading = true;
    notifyListeners();
    final temp = await _token.getUserID();
    final response = await _api.getProfile(temp);
    _jobSeekerProfileList = response;
    isLoading = false;
    notifyListeners();
  }
}