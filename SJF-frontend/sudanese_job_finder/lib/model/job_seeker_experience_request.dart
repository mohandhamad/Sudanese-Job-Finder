import 'dart:convert';

JobSeekerExperienceRequest jobSeekerExperienceRequestFromJson(String str) =>
    JobSeekerExperienceRequest.fromJson(json.decode(str));

String jobSeekerExperienceRequestToJson(JobSeekerExperienceRequest data) =>
    json.encode(data.toJson());

class JobSeekerExperienceRequest {
  int? jobSeekerProfile;
  String? experienceRole;
  DateTime? startDate;
  DateTime? endDate;
  String? jobDuties;
  String? implementedProjects;
  int? createdBy;
  int? modifiedBy;
  bool? isDelete;

  JobSeekerExperienceRequest({
    this.jobSeekerProfile,
    this.experienceRole,
    this.startDate,
    this.endDate,
    this.jobDuties,
    this.implementedProjects,
    this.createdBy,
    this.modifiedBy,
    this.isDelete,
  });

  JobSeekerExperienceRequest copyWith({
    int? jobSeekerProfile,
    String? experienceRole,
    DateTime? startDate,
    DateTime? endDate,
    String? jobDuties,
    String? implementedProjects,
    int? createdBy,
    int? modifiedBy,
    bool? isDelete,
  }) =>
      JobSeekerExperienceRequest(
        jobSeekerProfile: jobSeekerProfile ?? this.jobSeekerProfile,
        experienceRole: experienceRole ?? this.experienceRole,
        startDate: startDate ?? this.startDate,
        endDate: endDate ?? this.endDate,
        jobDuties: jobDuties ?? this.jobDuties,
        implementedProjects: implementedProjects ?? this.implementedProjects,
        createdBy: createdBy ?? this.createdBy,
        modifiedBy: modifiedBy ?? this.modifiedBy,
        isDelete: isDelete ?? this.isDelete,
      );

  factory JobSeekerExperienceRequest.fromJson(Map<String, dynamic> json) =>
      JobSeekerExperienceRequest(
        jobSeekerProfile: json["job_seeker_profile"],
        experienceRole: json["experience_role"],
        startDate: json["start_date"] == null
            ? null
            : DateTime.parse(json["start_date"]),
        endDate:
            json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
        jobDuties: json["job_duties"],
        implementedProjects: json["implemented_projects"],
        createdBy: json["created_by"],
        modifiedBy: json["modified_by"],
        isDelete: json["is_delete"],
      );

  Map<String, dynamic> toJson() => {
        "job_seeker_profile": jobSeekerProfile,
        "experience_role": experienceRole,
        "start_date":
            "${startDate!.year.toString().padLeft(4, '0')}-${startDate!.month.toString().padLeft(2, '0')}-${startDate!.day.toString().padLeft(2, '0')}",
        "end_date":
            "${endDate!.year.toString().padLeft(4, '0')}-${endDate!.month.toString().padLeft(2, '0')}-${endDate!.day.toString().padLeft(2, '0')}",
        "job_duties": jobDuties,
        "implemented_projects": implementedProjects,
        "created_by": createdBy,
        "modified_by": modifiedBy,
        "is_delete": isDelete,
      };

  void clear() {
    jobSeekerProfile = null;
    experienceRole = null;
    startDate = null;
    endDate = null;
    jobDuties = null;
    implementedProjects = null;
    createdBy = null;
    modifiedBy = null;
    isDelete = null;
  }
}
