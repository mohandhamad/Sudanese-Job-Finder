import 'dart:convert';
import 'job_application_seeker_detail_response.dart';
import 'job_seeker_profile_response.dart' as profile;

// Deserialization: Converts a JSON string into a List<InterviewResponse>
List<InterviewResponse> interviewResponseListFromJson(String str) =>
    List<InterviewResponse>.from(
        json.decode(str).map((x) => InterviewResponse.fromJson(x)));

// Serialization: Converts a List<InterviewResponse> into a JSON string
String interviewResponseListToJson(List<InterviewResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class InterviewResponse {
  int? id;
  CompanyJob? companyJob;
  profile.JobSeekerProfile jobSeekerProfile; // Made non-nullable
  JobApplication? jobApplication;
  DateTime? time;
  int? createdBy;
  int? modifiedBy;
  String? status;

  InterviewResponse({
    this.id,
    this.companyJob,
    required this.jobSeekerProfile, // Made required
    this.jobApplication,
    this.time,
    this.createdBy,
    this.modifiedBy,
    this.status,
  });

  factory InterviewResponse.fromJson(Map<String, dynamic> json) =>
      InterviewResponse(
        id: json["id"],
        companyJob: json["company_job"] == null
            ? null
            : CompanyJob.fromJson(json["company_job"]),
        jobSeekerProfile: profile.JobSeekerProfile.fromJson(
            json["job_seeker_profile"]), // Made non-nullable
        jobApplication: json["job_application"] == null
            ? null
            : JobApplication.fromJson(json["job_application"]),
        time: json["time"] == null ? null : DateTime.parse(json["time"]),
        createdBy: json["created_by"],
        modifiedBy: json["modified_by"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "company_job": companyJob?.toJson(),
        "job_seeker_profile": jobSeekerProfile.toJson(), // Made non-nullable
        "job_application": jobApplication?.toJson(),
        "time": time?.toIso8601String(),
        "created_by": createdBy,
        "modified_by": modifiedBy,
        "status": status,
      };
}

class JobApplication {
  int? jobSeekerProfile;
  int? companyJob;
  int? applicationStatus;
  int? createdBy;
  int? modifiedBy;
  bool? isDelete;

  JobApplication({
    this.jobSeekerProfile,
    this.companyJob,
    this.applicationStatus,
    this.createdBy,
    this.modifiedBy,
    this.isDelete,
  });

  JobApplication copyWith({
    int? jobSeekerProfile,
    int? companyJob,
    int? applicationStatus,
    int? createdBy,
    int? modifiedBy,
    bool? isDelete,
  }) =>
      JobApplication(
        jobSeekerProfile: jobSeekerProfile ?? this.jobSeekerProfile,
        companyJob: companyJob ?? this.companyJob,
        applicationStatus: applicationStatus ?? this.applicationStatus,
        createdBy: createdBy ?? this.createdBy,
        modifiedBy: modifiedBy ?? this.modifiedBy,
        isDelete: isDelete ?? this.isDelete,
      );

  factory JobApplication.fromJson(Map<String, dynamic> json) => JobApplication(
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

// class CompanyJob {
//   factory CompanyJob.fromJson(Map<String, dynamic> json) {

//   }

//   Map<String, dynamic> toJson() {

//   }
// }

// class JobSeekerProfile {
  
//   factory JobSeekerProfile.fromJson(Map<String, dynamic> json) {
    
//   }

//   Map<String, dynamic> toJson() {
   
//   }
// }
