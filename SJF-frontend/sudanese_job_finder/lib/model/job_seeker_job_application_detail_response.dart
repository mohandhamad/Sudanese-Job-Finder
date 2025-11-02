import 'dart:convert';

List<JobSeekerJobApplicationDetailResponse>
    jobSeekerJobApplicationDetailResponseFromJson(String str) =>
        List<JobSeekerJobApplicationDetailResponse>.from(json
            .decode(str)
            .map((x) => JobSeekerJobApplicationDetailResponse.fromJson(x)));

String jobSeekerJobApplicationDetailResponseToJson(
        List<JobSeekerJobApplicationDetailResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class JobSeekerJobApplicationDetailResponse {
  int? id;
  int? jobSeekerProfile;
  CompanyJob? companyJob;
  ApplicationStatus? applicationStatus;
  int? createdBy;
  int? modifiedBy;
  bool? isDelete;
  CompanyProfile? companyProfile;
  List<CompanyImage>? companyImages;

  JobSeekerJobApplicationDetailResponse({
    this.id,
    this.jobSeekerProfile,
    this.companyJob,
    this.applicationStatus,
    this.createdBy,
    this.modifiedBy,
    this.isDelete,
    this.companyProfile,
    this.companyImages,
  });

  JobSeekerJobApplicationDetailResponse copyWith({
    int? id,
    int? jobSeekerProfile,
    CompanyJob? companyJob,
    ApplicationStatus? applicationStatus,
    int? createdBy,
    int? modifiedBy,
    bool? isDelete,
    CompanyProfile? companyProfile,
    List<CompanyImage>? companyImages,
  }) =>
      JobSeekerJobApplicationDetailResponse(
        id: id ?? this.id,
        jobSeekerProfile: jobSeekerProfile ?? this.jobSeekerProfile,
        companyJob: companyJob ?? this.companyJob,
        applicationStatus: applicationStatus ?? this.applicationStatus,
        createdBy: createdBy ?? this.createdBy,
        modifiedBy: modifiedBy ?? this.modifiedBy,
        isDelete: isDelete ?? this.isDelete,
        companyProfile: companyProfile ?? this.companyProfile,
        companyImages: companyImages ?? this.companyImages,
      );

  factory JobSeekerJobApplicationDetailResponse.fromJson(
          Map<String, dynamic> json) =>
      JobSeekerJobApplicationDetailResponse(
        id: json["id"],
        jobSeekerProfile: json["job_seeker_profile"],
        companyJob: json["company_job"] == null
            ? null
            : CompanyJob.fromJson(json["company_job"]),
        applicationStatus: json["application_status"] == null
            ? null
            : ApplicationStatus.fromJson(json["application_status"]),
        createdBy: json["created_by"],
        modifiedBy: json["modified_by"],
        isDelete: json["is_delete"],
        companyProfile: json["company_profile"] == null
            ? null
            : CompanyProfile.fromJson(json["company_profile"]),
        companyImages: json["company_images"] == null
            ? []
            : List<CompanyImage>.from(
                json["company_images"]!.map((x) => CompanyImage.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "job_seeker_profile": jobSeekerProfile,
        "company_job": companyJob?.toJson(),
        "application_status": applicationStatus?.toJson(),
        "created_by": createdBy,
        "modified_by": modifiedBy,
        "is_delete": isDelete,
        "company_profile": companyProfile?.toJson(),
        "company_images": companyImages == null
            ? []
            : List<dynamic>.from(companyImages!.map((x) => x.toJson())),
      };
}

class ApplicationStatus {
  int? id;
  String? description;
  int? createdBy;
  int? modifiedBy;
  bool? isDelete;

  ApplicationStatus({
    this.id,
    this.description,
    this.createdBy,
    this.modifiedBy,
    this.isDelete,
  });

  ApplicationStatus copyWith({
    int? id,
    String? description,
    int? createdBy,
    int? modifiedBy,
    bool? isDelete,
  }) =>
      ApplicationStatus(
        id: id ?? this.id,
        description: description ?? this.description,
        createdBy: createdBy ?? this.createdBy,
        modifiedBy: modifiedBy ?? this.modifiedBy,
        isDelete: isDelete ?? this.isDelete,
      );

  factory ApplicationStatus.fromJson(Map<String, dynamic> json) =>
      ApplicationStatus(
        id: json["id"],
        description: json["description"],
        createdBy: json["created_by"],
        modifiedBy: json["modified_by"],
        isDelete: json["is_delete"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "description": description,
        "created_by": createdBy,
        "modified_by": modifiedBy,
        "is_delete": isDelete,
      };
}

class CompanyImage {
  int? id;
  int? companyProfile;
  String? title;
  String? description;
  String? image;
  String? uniqueIdentity;
  DateTime? createdAt;
  DateTime? modifiedAt;
  int? createdBy;
  int? modifiedBy;
  bool? isDelete;

  CompanyImage({
    this.id,
    this.companyProfile,
    this.title,
    this.description,
    this.image,
    this.uniqueIdentity,
    this.createdAt,
    this.modifiedAt,
    this.createdBy,
    this.modifiedBy,
    this.isDelete,
  });

  CompanyImage copyWith({
    int? id,
    int? companyProfile,
    String? title,
    String? description,
    String? image,
    String? uniqueIdentity,
    DateTime? createdAt,
    DateTime? modifiedAt,
    int? createdBy,
    int? modifiedBy,
    bool? isDelete,
  }) =>
      CompanyImage(
        id: id ?? this.id,
        companyProfile: companyProfile ?? this.companyProfile,
        title: title ?? this.title,
        description: description ?? this.description,
        image: image ?? this.image,
        uniqueIdentity: uniqueIdentity ?? this.uniqueIdentity,
        createdAt: createdAt ?? this.createdAt,
        modifiedAt: modifiedAt ?? this.modifiedAt,
        createdBy: createdBy ?? this.createdBy,
        modifiedBy: modifiedBy ?? this.modifiedBy,
        isDelete: isDelete ?? this.isDelete,
      );

  factory CompanyImage.fromJson(Map<String, dynamic> json) => CompanyImage(
        id: json["id"],
        companyProfile: json["company_profile"],
        title: json["title"],
        description: json["description"],
        image: json["image"],
        uniqueIdentity: json["unique_identity"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        modifiedAt: json["modified_at"] == null
            ? null
            : DateTime.parse(json["modified_at"]),
        createdBy: json["created_by"],
        modifiedBy: json["modified_by"],
        isDelete: json["is_delete"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "company_profile": companyProfile,
        "title": title,
        "description": description,
        "image": image,
        "unique_identity": uniqueIdentity,
        "created_at": createdAt?.toIso8601String(),
        "modified_at": modifiedAt?.toIso8601String(),
        "created_by": createdBy,
        "modified_by": modifiedBy,
        "is_delete": isDelete,
      };
}

class CompanyJob {
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

  CompanyJob({
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

  CompanyJob copyWith({
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
      CompanyJob(
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

  factory CompanyJob.fromJson(Map<String, dynamic> json) => CompanyJob(
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

class CompanyProfile {
  int? id;
  String? companyName;
  String? image;
  String? mobile;
  String? description;
  String? webSite;
  int? createdBy;
  int? modifiedBy;
  bool? isDelete;

  CompanyProfile({
    this.id,
    this.companyName,
    this.image,
    this.mobile,
    this.description,
    this.webSite,
    this.createdBy,
    this.modifiedBy,
    this.isDelete,
  });

  CompanyProfile copyWith({
    int? id,
    String? companyName,
    String? image,
    String? mobile,
    String? description,
    String? webSite,
    int? createdBy,
    int? modifiedBy,
    bool? isDelete,
  }) =>
      CompanyProfile(
        id: id ?? this.id,
        companyName: companyName ?? this.companyName,
        image: image ?? this.image,
        mobile: mobile ?? this.mobile,
        description: description ?? this.description,
        webSite: webSite ?? this.webSite,
        createdBy: createdBy ?? this.createdBy,
        modifiedBy: modifiedBy ?? this.modifiedBy,
        isDelete: isDelete ?? this.isDelete,
      );

  factory CompanyProfile.fromJson(Map<String, dynamic> json) => CompanyProfile(
        id: json["id"],
        companyName: json["company_name"],
        image: json["image"],
        mobile: json["mobile"],
        description: json["description"],
        webSite: json["web_site"],
        createdBy: json["created_by"],
        modifiedBy: json["modified_by"],
        isDelete: json["is_delete"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "company_name": companyName,
        "image": image,
        "mobile": mobile,
        "description": description,
        "web_site": webSite,
        "created_by": createdBy,
        "modified_by": modifiedBy,
        "is_delete": isDelete,
      };
}
