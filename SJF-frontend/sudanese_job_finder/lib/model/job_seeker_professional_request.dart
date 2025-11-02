import 'dart:convert';

JobSeekerProfessionalRequest jobSeekerProfessionalRequestFromJson(String str) =>
    JobSeekerProfessionalRequest.fromJson(json.decode(str));

String jobSeekerProfessionalRequestToJson(JobSeekerProfessionalRequest data) =>
    json.encode(data.toJson());

class JobSeekerProfessionalRequest {
  int? jobSeekerProfile;
  String? type;
  String? mark;
  DateTime? examDate;
  int? createdBy;
  int? modifiedBy;
  bool? isDelete;

  JobSeekerProfessionalRequest({
    this.jobSeekerProfile,
    this.type,
    this.mark,
    this.examDate,
    this.createdBy,
    this.modifiedBy,
    this.isDelete,
  });

  JobSeekerProfessionalRequest copyWith({
    int? jobSeekerProfile,
    String? type,
    String? mark,
    DateTime? examDate,
    int? createdBy,
    int? modifiedBy,
    bool? isDelete,
  }) =>
      JobSeekerProfessionalRequest(
        jobSeekerProfile: jobSeekerProfile ?? this.jobSeekerProfile,
        type: type ?? this.type,
        mark: mark ?? this.mark,
        examDate: examDate ?? this.examDate,
        createdBy: createdBy ?? this.createdBy,
        modifiedBy: modifiedBy ?? this.modifiedBy,
        isDelete: isDelete ?? this.isDelete,
      );

  factory JobSeekerProfessionalRequest.fromJson(Map<String, dynamic> json) =>
      JobSeekerProfessionalRequest(
        jobSeekerProfile: json["job_seeker_profile"],
        type: json["type"],
        mark: json["mark"],
        examDate: json["exam_date"] == null
            ? null
            : DateTime.parse(json["exam_date"]),
        createdBy: json["created_by"],
        modifiedBy: json["modified_by"],
        isDelete: json["is_delete"],
      );

  Map<String, dynamic> toJson() => {
        "job_seeker_profile": jobSeekerProfile,
        "type": type,
        "mark": mark,
        "exam_date":
            "${examDate!.year.toString().padLeft(4, '0')}-${examDate!.month.toString().padLeft(2, '0')}-${examDate!.day.toString().padLeft(2, '0')}",
        "created_by": createdBy,
        "modified_by": modifiedBy,
        "is_delete": isDelete,
      };

  void clear() {
    jobSeekerProfile = null;
    type = null;
    mark = null;
    examDate = null;
    createdBy = null;
    modifiedBy = null;
    isDelete = false;
  }
}
