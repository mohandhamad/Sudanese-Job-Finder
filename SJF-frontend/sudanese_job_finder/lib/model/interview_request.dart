import 'job_application_seeker_detail_response.dart';
// import 'package:intl/intl.dart';

class InterviewRequest {
  final DateTime time;
  final CompanyJob? companyJob;
  final JobSeekerProfile? jobSeekerProfile;
  final String status;

  InterviewRequest({
    required this.time,
    required this.companyJob,
    required this.jobSeekerProfile,
    required this.status,
  });

  Map<String, dynamic> toJson() {
    // final DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
    return {
      // 'time': formatter.format(time),
      'time': time.toIso8601String(),
      'companyJob': companyJob?.toJson(),
      'jobSeekerProfile': jobSeekerProfile?.toJson(),
      'status': status,
    };
  }

  factory InterviewRequest.fromJson(Map<String, dynamic> json) {
    return InterviewRequest(
      time: DateTime.parse(json['time']),
      companyJob: json['companyJob'] != null
          ? CompanyJob.fromJson(json['companyJob'])
          : null,
      jobSeekerProfile: json['jobSeekerProfile'] != null
          ? JobSeekerProfile.fromJson(json['jobSeekerProfile'])
          : null,
      status: json['status'],
    );
  }
}
