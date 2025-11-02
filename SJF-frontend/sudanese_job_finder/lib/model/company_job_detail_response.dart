import 'dart:convert';

List<CompanyJobDetailResponse> companyJobDetailResponseFromJson(String str) =>
    List<CompanyJobDetailResponse>.from(
        json.decode(str).map((x) => CompanyJobDetailResponse.fromJson(x)));

String companyJobDetailResponseToJson(List<CompanyJobDetailResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CompanyJobDetailResponse {
  int? id;
  CompanyProfile? companyProfile;
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
  List<CompanyImage>? companyImages;

  CompanyJobDetailResponse({
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
    this.companyImages,
  });

  factory CompanyJobDetailResponse.fromJson(Map<String, dynamic> json) =>
      CompanyJobDetailResponse(
        id: json["id"],
        companyProfile: json["company_profile"] == null
            ? null
            : CompanyProfile.fromJson(json["company_profile"]),
        jobTitle: json["job_title"],
        jobField: json["job_field"],
        jobType: json["job_type"],
        skills: json["skills"],
        expLevel: json["exp_level"],
        jobDescription: json["job_description"],
        salary: json["salary"],
        deadline:
            json["deadline"] == null ? null : DateTime.parse(json["deadline"]),
        createdBy: json["created_by"],
        modifiedBy: json["modified_by"],
        isDelete: json["is_delete"],
        companyImages: json["company_images"] == null
            ? []
            : List<CompanyImage>.from(
                json["company_images"]!.map((x) => CompanyImage.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "company_profile": companyProfile?.toJson(),
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
        "company_images": companyImages == null
            ? []
            : List<dynamic>.from(companyImages!.map((x) => x.toJson())),
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
