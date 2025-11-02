import 'dart:convert';

List<JobSeekerContactResponse> jobSeekerContactResponseFromJson(String str) =>
    List<JobSeekerContactResponse>.from(
        json.decode(str).map((x) => JobSeekerContactResponse.fromJson(x)));

String jobSeekerContactResponseToJson(List<JobSeekerContactResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class JobSeekerContactResponse {
  int? id;
  int? jobSeekerProfile;
  String? type;
  String? contactNumber;
  int? createdBy;
  int? modifiedBy;
  bool? isDelete;

  JobSeekerContactResponse({
    this.id,
    this.jobSeekerProfile,
    this.type,
    this.contactNumber,
    this.createdBy,
    this.modifiedBy,
    this.isDelete,
  });

  JobSeekerContactResponse copyWith({
    int? id,
    int? jobSeekerProfile,
    String? type,
    String? contactNumber,
    int? createdBy,
    int? modifiedBy,
    bool? isDelete,
  }) =>
      JobSeekerContactResponse(
        id: id ?? this.id,
        jobSeekerProfile: jobSeekerProfile ?? this.jobSeekerProfile,
        type: type ?? this.type,
        contactNumber: contactNumber ?? this.contactNumber,
        createdBy: createdBy ?? this.createdBy,
        modifiedBy: modifiedBy ?? this.modifiedBy,
        isDelete: isDelete ?? this.isDelete,
      );

  factory JobSeekerContactResponse.fromJson(Map<String, dynamic> json) =>
      JobSeekerContactResponse(
        id: json["id"],
        jobSeekerProfile: json["job_seeker_profile"],
        type: json["type"],
        contactNumber: json["contact_number"],
        createdBy: json["created_by"],
        modifiedBy: json["modified_by"],
        isDelete: json["is_delete"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "job_seeker_profile": jobSeekerProfile,
        "type": type,
        "contact_number": contactNumber,
        "created_by": createdBy,
        "modified_by": modifiedBy,
        "is_delete": isDelete,
      };
}
