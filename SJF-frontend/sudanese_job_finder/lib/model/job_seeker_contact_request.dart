import 'dart:convert';

JobSeekerContactRequest jobSeekerContactRequestFromJson(String str) =>
    JobSeekerContactRequest.fromJson(json.decode(str));

String jobSeekerContactRequestToJson(JobSeekerContactRequest data) =>
    json.encode(data.toJson());

class JobSeekerContactRequest {
  int? jobSeekerProfile;
  String? type;
  String? contactNumber;
  int? createdBy;
  int? modifiedBy;
  bool? isDelete;

  JobSeekerContactRequest({
    this.jobSeekerProfile,
    this.type,
    this.contactNumber,
    this.createdBy,
    this.modifiedBy,
    this.isDelete,
  });

  JobSeekerContactRequest copyWith({
    int? jobSeekerProfile,
    String? type,
    String? contactNumber,
    int? createdBy,
    int? modifiedBy,
    bool? isDelete,
  }) =>
      JobSeekerContactRequest(
        jobSeekerProfile: jobSeekerProfile ?? this.jobSeekerProfile,
        type: type ?? this.type,
        contactNumber: contactNumber ?? this.contactNumber,
        createdBy: createdBy ?? this.createdBy,
        modifiedBy: modifiedBy ?? this.modifiedBy,
        isDelete: isDelete ?? this.isDelete,
      );

  factory JobSeekerContactRequest.fromJson(Map<String, dynamic> json) =>
      JobSeekerContactRequest(
        jobSeekerProfile: json["job_seeker_profile"],
        type: json["type"],
        contactNumber: json["contact_number"],
        createdBy: json["created_by"],
        modifiedBy: json["modified_by"],
        isDelete: json["is_delete"],
      );

  Map<String, dynamic> toJson() => {
        "job_seeker_profile": jobSeekerProfile,
        "type": type,
        "contact_number": contactNumber,
        "created_by": createdBy,
        "modified_by": modifiedBy,
        "is_delete": isDelete,
      };

  void clear() {
    jobSeekerProfile = null;
    type = null;
    contactNumber = null;
    createdBy = null;
    modifiedBy = null;
    isDelete = false;
  }
}
