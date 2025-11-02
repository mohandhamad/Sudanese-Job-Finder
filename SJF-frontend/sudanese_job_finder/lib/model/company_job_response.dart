import 'dart:convert';

import 'package:sudanese_job_finder/model/job_application_seeker_detail_response.dart';

List<CompanyJobResponse> companyJobResponseFromJson(String str) =>
    List<CompanyJobResponse>.from(
        json.decode(str).map((x) => CompanyJobResponse.fromJson(x)));

String companyJobResponseToJson(List<CompanyJobResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

CompanyJob singleCompanyJobFromJson(String str) {
  final jsonData = json.decode(str);
  if (jsonData is List) {
    return CompanyJob.fromJson(jsonData[0]);
  } else if (jsonData is Map<String, dynamic>) {
    return CompanyJob.fromJson(jsonData);
  } else {
    throw Exception('Invalid JSON format');
  }
}

class CompanyJobResponse {
  int? id;
  int? companyProfile;
  String? jobTitle;
  String? jobType;
  String? jobField;
  String? skills;
  String? expLevel;
  String? jobDescription;
  String? salary;
  DateTime? deadline;
  int? createdBy;
  int? modifiedBy;
  bool? isDelete;

  CompanyJobResponse({
    this.id,
    this.companyProfile,
    this.jobTitle,
    this.jobType,
    this.jobField,
    this.skills,
    this.expLevel,
    this.jobDescription,
    this.salary,
    this.deadline,
    this.createdBy,
    this.modifiedBy,
    this.isDelete,
  });

  CompanyJobResponse copyWith({
    int? id,
    int? companyProfile,
    String? jobTitle,
    String? jobType,
    String? jobField,
    String? skills,
    String? expLevel,
    String? jobDescription,
    String? salary,
    DateTime? deadline,
    int? createdBy,
    int? modifiedBy,
    bool? isDelete,
  }) =>
      CompanyJobResponse(
        id: id ?? this.id,
        companyProfile: companyProfile ?? this.companyProfile,
        jobTitle: jobTitle ?? this.jobTitle,
        jobType: jobType ?? this.jobType,
        jobField: jobField ?? this.jobField,
        skills: skills ?? this.skills,
        expLevel: expLevel ?? this.expLevel,
        jobDescription: jobDescription ?? this.jobDescription,
        salary: salary ?? this.salary,
        deadline: deadline ?? this.deadline,
        createdBy: createdBy ?? this.createdBy,
        modifiedBy: modifiedBy ?? this.modifiedBy,
        isDelete: isDelete ?? this.isDelete,
      );

  factory CompanyJobResponse.fromJson(Map<String, dynamic> json) =>
      CompanyJobResponse(
        id: json["id"],
        companyProfile: json["company_profile"],
        jobTitle: json["job_title"],
        jobType: json["job_type"],
        jobField: json["job_field"],
        skills: json["skills"],
        expLevel: json["exp_level"],
        jobDescription: json["job_description"],
        salary: json["salary"],
        deadline:
            json["end_at"] == null ? null : DateTime.parse(json["end_at"]),
        createdBy: json["created_by"],
        modifiedBy: json["modified_by"],
        isDelete: json["is_delete"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "company_profile": companyProfile,
        "job_title": jobTitle,
        "job_type": jobType,
        "job_field": jobField,
        "skills": skills,
        "exp_level": expLevel,
        "job_description": jobDescription,
        "salary": salary,
        "end_at": deadline?.toIso8601String(),
        "created_by": createdBy,
        "modified_by": modifiedBy,
        "is_delete": isDelete,
      };
}

// class CompanyJob {
//   int? id;
//   int? companyProfile;
//   String? jobTitle;
//   String? jobType;
//   String? jobField;
//   String? skills;
//   String? expLevel;
//   String? jobDescription;
//   String? salary;
//   DateTime? deadline;
//   int? createdBy;
//   int? modifiedBy;
//   bool? isDelete;

//   CompanyJob({
//     this.id,
//     this.companyProfile,
//     this.jobTitle,
//     this.jobType,
//     this.jobField,
//     this.skills,
//     this.expLevel,
//     this.jobDescription,
//     this.salary,
//     this.deadline,
//     this.createdBy,
//     this.modifiedBy,
//     this.isDelete,
//   });

//   CompanyJob copyWith({
//     int? id,
//     int? companyProfile,
//     String? jobTitle,
//     String? jobType,
//     String? jobField,
//     String? skills,
//     String? expLevel,
//     String? jobDescription,
//     String? salary,
//     DateTime? deadline,
//     int? createdBy,
//     int? modifiedBy,
//     bool? isDelete,
//   }) =>
//       CompanyJob(
//         id: id ?? this.id,
//         companyProfile: companyProfile ?? this.companyProfile,
//         jobTitle: jobTitle ?? this.jobTitle,
//         jobType: jobType ?? this.jobType,
//         jobField: jobField ?? this.jobField,
//         skills: skills ?? this.skills,
//         expLevel: expLevel ?? this.expLevel,
//         jobDescription: jobDescription ?? this.jobDescription,
//         salary: salary ?? this.salary,
//         deadline: deadline ?? this.deadline,
//         createdBy: createdBy ?? this.createdBy,
//         modifiedBy: modifiedBy ?? this.modifiedBy,
//         isDelete: isDelete ?? this.isDelete,
//       );

//   factory CompanyJob.fromJson(Map<String, dynamic> json) => CompanyJob(
//         id: json["id"],
//         companyProfile: json["company_profile"],
//         jobTitle: json["job_title"],
//         jobType: json["job_type"],
//         jobField: json["job_field"],
//         skills: json["skills"],
//         expLevel: json["exp_level"],
//         jobDescription: json["job_description"],
//         salary: json["salary"],
//         deadline:
//             json["end_at"] == null ? null : DateTime.parse(json["end_at"]),
//         createdBy: json["created_by"],
//         modifiedBy: json["modified_by"],
//         isDelete: json["is_delete"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "company_profile": companyProfile,
//         "job_title": jobTitle,
//         "job_type": jobType,
//         "job_field": jobField,
//         "skills": skills,
//         "exp_level": expLevel,
//         "job_description": jobDescription,
//         "salary": salary,
//         "end_at": deadline?.toIso8601String(),
//         "created_by": createdBy,
//         "modified_by": modifiedBy,
//         "is_delete": isDelete,
//       };
// }
