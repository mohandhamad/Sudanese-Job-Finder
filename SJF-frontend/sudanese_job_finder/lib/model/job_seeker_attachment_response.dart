import 'dart:convert';

List<JobSeekerAttachmentResponse> jobSeekerAttachmentResponseFromJson(
        String str) =>
    List<JobSeekerAttachmentResponse>.from(
        json.decode(str).map((x) => JobSeekerAttachmentResponse.fromJson(x)));

String jobSeekerAttachmentResponseToJson(
        List<JobSeekerAttachmentResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class JobSeekerAttachmentResponse {
  int? id;
  int? jobSeekerProfile;
  String? jobSeekerAttachmentType;
  String? fileData;
  int? createdBy;
  int? modifiedBy;
  bool? isDelete;

  JobSeekerAttachmentResponse({
    this.id,
    this.jobSeekerProfile,
    this.jobSeekerAttachmentType,
    this.fileData,
    this.createdBy,
    this.modifiedBy,
    this.isDelete,
  });

  JobSeekerAttachmentResponse copyWith({
    int? id,
    int? jobSeekerProfile,
    String? jobSeekerAttachmentType,
    String? fileData,
    int? createdBy,
    int? modifiedBy,
    bool? isDelete,
  }) =>
      JobSeekerAttachmentResponse(
        id: id ?? this.id,
        jobSeekerProfile: jobSeekerProfile ?? this.jobSeekerProfile,
        jobSeekerAttachmentType:
            jobSeekerAttachmentType ?? this.jobSeekerAttachmentType,
        fileData: fileData ?? this.fileData,
        createdBy: createdBy ?? this.createdBy,
        modifiedBy: modifiedBy ?? this.modifiedBy,
        isDelete: isDelete ?? this.isDelete,
      );

  factory JobSeekerAttachmentResponse.fromJson(Map<String, dynamic> json) =>
      JobSeekerAttachmentResponse(
        id: json["id"],
        jobSeekerProfile: json["job_seeker_profile"],
        jobSeekerAttachmentType: json["job_seeker_attachment_type"],
        fileData: json["file_data"],
        createdBy: json["created_by"],
        modifiedBy: json["modified_by"],
        isDelete: json["is_delete"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "job_seeker_profile": jobSeekerProfile,
        "job_seeker_attachment_type": jobSeekerAttachmentType,
        "file_data": fileData,
        "created_by": createdBy,
        "modified_by": modifiedBy,
        "is_delete": isDelete,
      };
}
