import 'dart:convert';

JobViewRequest jobViewRequestFromJson(String str) =>
    JobViewRequest.fromJson(json.decode(str));

String jobViewRequestToJson(JobViewRequest data) => json.encode(data.toJson());

class JobViewRequest {
  int? companyJob;
  int? jobSeeker;

  JobViewRequest({
    this.companyJob,
    this.jobSeeker,
  });

  JobViewRequest copyWith({
    int? companyJob,
    int? jobSeeker,
  }) {
    return JobViewRequest(
      companyJob: companyJob ?? this.companyJob,
      jobSeeker: jobSeeker ?? this.jobSeeker,
    );
  }

  factory JobViewRequest.fromJson(Map<String, dynamic> json) {
    return JobViewRequest(
      companyJob: json['company_job'],
      jobSeeker: json['job_seeker'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'company_job': companyJob,
      'job_seeker': jobSeeker,
    };
  }
}
