import 'dart:convert';

JobSeekerProfileRequest jobSeekerProfileRequestFromJson(String str) =>
    JobSeekerProfileRequest.fromJson(json.decode(str));

String jobSeekerProfileRequestToJson(JobSeekerProfileRequest data) =>
    json.encode(data.toJson());

class JobSeekerProfileRequest {
  int? id;
  String? image;
  String? nationalId;
  String? firstName;
  String? middleName;
  String? lastName;
  DateTime? birthDate;
  String? gender;
  String? maritalStatus;
  int? createdBy;
  int? modifiedBy;
  bool? isDelete;
  List<String>? skills;

  JobSeekerProfileRequest({
    this.id,
    this.image,
    this.nationalId,
    this.firstName,
    this.middleName,
    this.lastName,
    this.birthDate,
    this.gender,
    this.maritalStatus,
    this.createdBy,
    this.modifiedBy,
    this.isDelete,
    this.skills,
  });

  JobSeekerProfileRequest copyWith({
    int? id,
    String? image,
    String? nationalId,
    String? firstName,
    String? middleName,
    String? lastName,
    DateTime? birthDate,
    String? gender,
    String? maritalStatus,
    int? createdBy,
    int? modifiedBy,
    bool? isDelete,
    List<String>? skills,
  }) =>
      JobSeekerProfileRequest(
        id: id ?? this.id,
        image: image ?? this.image,
        nationalId: nationalId ?? this.nationalId,
        firstName: firstName ?? this.firstName,
        middleName: middleName ?? this.middleName,
        lastName: lastName ?? this.lastName,
        birthDate: birthDate ?? this.birthDate,
        gender: gender ?? this.gender,
        maritalStatus: maritalStatus ?? this.maritalStatus,
        createdBy: createdBy ?? this.createdBy,
        modifiedBy: modifiedBy ?? this.modifiedBy,
        isDelete: isDelete ?? this.isDelete,
        skills: skills ?? this.skills,
      );

  factory JobSeekerProfileRequest.fromJson(Map<String, dynamic> json) =>
      JobSeekerProfileRequest(
        id: json["id"],
        image: json["image"],
        nationalId: json["national_id"],
        firstName: json["first_name"],
        middleName: json["middle_name"],
        lastName: json["last_name"],
        birthDate: json["birth_date"] == null
            ? null
            : DateTime.parse(json["birth_date"]),
        gender: json["gender"],
        maritalStatus: json["marital_status"],
        createdBy: json["created_by"],
        modifiedBy: json["modified_by"],
        isDelete: json["is_delete"],
        skills: json["skills"] == null ? [] : List<String>.from(json["skills"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "national_id": nationalId,
        "first_name": firstName,
        "middle_name": middleName,
        "last_name": lastName,
        "birth_date": birthDate?.toIso8601String(),
        "gender": gender,
        "marital_status": maritalStatus,
        "created_by": createdBy,
        "modified_by": modifiedBy,
        "is_delete": isDelete,
        "skills": skills == null ? [] : List<dynamic>.from(skills!),
      };
}
