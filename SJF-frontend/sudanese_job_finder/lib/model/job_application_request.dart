import 'dart:convert';

JobApplicationRequest jobApplicationRequestFromJson(String str) =>
    JobApplicationRequest.fromJson(json.decode(str));

String jobApplicationRequestToJson(JobApplicationRequest data) =>
    json.encode(data.toJson());

class JobApplicationRequest {
  int? jobSeekerProfile;
  int? companyJob;
  int? applicationStatus;
  int? createdBy;
  int? modifiedBy;
  bool? isDelete;

  JobApplicationRequest({
    this.jobSeekerProfile,
    this.companyJob,
    this.applicationStatus,
    this.createdBy,
    this.modifiedBy,
    this.isDelete,
  });

  JobApplicationRequest copyWith({
    int? jobSeekerProfile,
    int? companyJob,
    int? applicationStatus,
    int? createdBy,
    int? modifiedBy,
    bool? isDelete,
  }) =>
      JobApplicationRequest(
        jobSeekerProfile: jobSeekerProfile ?? this.jobSeekerProfile,
        companyJob: companyJob ?? this.companyJob,
        applicationStatus: applicationStatus ?? this.applicationStatus,
        createdBy: createdBy ?? this.createdBy,
        modifiedBy: modifiedBy ?? this.modifiedBy,
        isDelete: isDelete ?? this.isDelete,
      );

  factory JobApplicationRequest.fromJson(Map<String, dynamic> json) =>
      JobApplicationRequest(
        jobSeekerProfile: json["job_seeker_profile"],
        companyJob: json["company_job"],
        applicationStatus: json["application_status"],
        createdBy: json["created_by"],
        modifiedBy: json["modified_by"],
        isDelete: json["is_delete"],
      );

  Map<String, dynamic> toJson() => {
        "job_seeker_profile": jobSeekerProfile,
        "company_job": companyJob,
        "application_status": applicationStatus,
        "created_by": createdBy,
        "modified_by": modifiedBy,
        "is_delete": isDelete,
      };
}
