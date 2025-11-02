import 'dart:convert';

JobSeekerAttachmentRequest jobSeekerAttachmentRequestFromJson(String str) =>
    JobSeekerAttachmentRequest.fromJson(json.decode(str));

String jobSeekerAttachmentRequestToJson(JobSeekerAttachmentRequest data) =>
    json.encode(data.toJson());

class JobSeekerAttachmentRequest {
  int? jobSeekerProfile;
  String? jobSeekerAttachmentType;
  String? fileData;
  int? createdBy;
  int? modifiedBy;
  bool? isDelete;

  JobSeekerAttachmentRequest({
    this.jobSeekerProfile,
    this.jobSeekerAttachmentType,
    this.fileData,
    this.createdBy,
    this.modifiedBy,
    this.isDelete,
  });

  JobSeekerAttachmentRequest copyWith({
    int? jobSeekerProfile,
    String? jobSeekerAttachmentType,
    String? fileData,
    int? createdBy,
    int? modifiedBy,
    bool? isDelete,
  }) =>
      JobSeekerAttachmentRequest(
        jobSeekerProfile: jobSeekerProfile ?? this.jobSeekerProfile,
        jobSeekerAttachmentType:
            jobSeekerAttachmentType ?? this.jobSeekerAttachmentType,
        fileData: fileData ?? this.fileData,
        createdBy: createdBy ?? this.createdBy,
        modifiedBy: modifiedBy ?? this.modifiedBy,
        isDelete: isDelete ?? this.isDelete,
      );

  factory JobSeekerAttachmentRequest.fromJson(Map<String, dynamic> json) =>
      JobSeekerAttachmentRequest(
        jobSeekerProfile: json["job_seeker_profile"],
        jobSeekerAttachmentType: json["job_seeker_attachment_type"],
        fileData: json["file_data"],
        createdBy: json["created_by"],
        modifiedBy: json["modified_by"],
        isDelete: json["is_delete"],
      );

  Map<String, dynamic> toJson() => {
        "job_seeker_profile": jobSeekerProfile,
        "job_seeker_attachment_type": jobSeekerAttachmentType,
        "file_data": fileData,
        "created_by": createdBy,
        "modified_by": modifiedBy,
        "is_delete": isDelete,
      };
  void clear() {
    jobSeekerProfile = null;
    jobSeekerAttachmentType = null;
    fileData = null;
    createdBy = null;
    modifiedBy = null;
    isDelete = false;
  }
}
