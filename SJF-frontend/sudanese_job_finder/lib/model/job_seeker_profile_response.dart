import 'dart:convert';

List<JobSeekerProfileResponse> jobSeekerProfileResponseFromJson(String str) =>
    List<JobSeekerProfileResponse>.from(
        json.decode(str).map((x) => JobSeekerProfileResponse.fromJson(x)));

String jobSeekerProfileResponseToJson(List<JobSeekerProfileResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

JobSeekerProfile singleJobSeekerProfileFromJson(String str) {
  final jsonData = json.decode(str);
  if (jsonData is List) {
    return JobSeekerProfile.fromJson(jsonData[0]);
  } else if (jsonData is Map<String, dynamic>) {
    return JobSeekerProfile.fromJson(jsonData);
  } else {
    throw Exception('Invalid JSON format');
  }
}

class JobSeekerProfileResponse {
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
  List<String>? skills; // Add the skills field

  JobSeekerProfileResponse({
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
    this.skills, // Initialize the skills field
  });

  JobSeekerProfileResponse copyWith({
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
    List<String>? skills, // Add the skills field to the copyWith method
  }) =>
      JobSeekerProfileResponse(
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
        skills: skills ?? this.skills, // Initialize the skills field
      );

  factory JobSeekerProfileResponse.fromJson(Map<String, dynamic> json) =>
      JobSeekerProfileResponse(
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
        skills: json["skills"] == null
            ? []
            : List<String>.from(json["skills"]), // Parse the skills field
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "national_id": nationalId,
        "first_name": firstName,
        "middle_name": middleName,
        "last_name": lastName,
        "birth_date": birthDate == null
            ? null
            : "${birthDate!.year.toString().padLeft(4, '0')}-${birthDate!.month.toString().padLeft(2, '0')}-${birthDate!.day.toString().padLeft(2, '0')}",
        "gender": gender,
        "marital_status": maritalStatus,
        "created_by": createdBy,
        "modified_by": modifiedBy,
        "is_delete": isDelete,
        "skills": skills == null
            ? []
            : List<dynamic>.from(skills!), // Serialize the skills field
      };
}

class JobSeekerProfile {
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

  JobSeekerProfile({
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

  JobSeekerProfile copyWith({
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
      JobSeekerProfile(
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

  factory JobSeekerProfile.fromJson(Map<String, dynamic> json) =>
      JobSeekerProfile(
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
        "birth_date": birthDate == null
            ? null
            : "${birthDate!.year.toString().padLeft(4, '0')}-${birthDate!.month.toString().padLeft(2, '0')}-${birthDate!.day.toString().padLeft(2, '0')}",
        "gender": gender,
        "marital_status": maritalStatus,
        "created_by": createdBy,
        "modified_by": modifiedBy,
        "is_delete": isDelete,
        "skills": skills == null ? [] : List<dynamic>.from(skills!),
      };
}
