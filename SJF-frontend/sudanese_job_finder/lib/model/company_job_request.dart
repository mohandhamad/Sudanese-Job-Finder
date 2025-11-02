import 'dart:convert';

CompanyJobRequest companyJobRequestFromJson(String str) =>
    CompanyJobRequest.fromJson(json.decode(str));

String companyJobRequestToJson(CompanyJobRequest data) =>
    json.encode(data.toJson());

class CompanyJobRequest {
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

  CompanyJobRequest({
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

  CompanyJobRequest copyWith({
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
      CompanyJobRequest(
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

  factory CompanyJobRequest.fromJson(Map<String, dynamic> json) =>
      CompanyJobRequest(
        companyProfile: json["company_profile"],
        jobTitle: json["job_title"],
        jobType: json["job_type"],
        jobField: json["job_field"],
        skills: json["skills"],
        expLevel: json["exp_level"],
        jobDescription: json["job_description"],
        salary: json["salary"],
        deadline:
            json["deadline"] == null ? null : DateTime.parse(json["deadline"]),
        createdBy: json["created_by"],
        modifiedBy: json["modified_by"],
        isDelete: json["is_delete"],
      );

  Map<String, dynamic> toJson() => {
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

  void clear() {
    companyProfile = null;
    jobTitle = null;
    jobType = null;
    jobField = null;
    skills = null;
    expLevel = null;
    jobDescription = null;
    salary = null;
    deadline = null;
    createdBy = null;
    modifiedBy = null;
    isDelete = false;
  }
}
