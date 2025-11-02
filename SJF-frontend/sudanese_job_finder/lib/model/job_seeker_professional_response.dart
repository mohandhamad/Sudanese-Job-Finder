import 'dart:convert';

List<JobSeekerProfessionalResponse> jobSeekerProfessionalResponseFromJson(
        String str) =>
    List<JobSeekerProfessionalResponse>.from(
        json.decode(str).map((x) => JobSeekerProfessionalResponse.fromJson(x)));

String jobSeekerProfessionalResponseToJson(
        List<JobSeekerProfessionalResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class JobSeekerProfessionalResponse {
  int? id;
  int? jobSeekerProfile;
  String? type;
  String? mark;
  DateTime? examDate;
  int? createdBy;
  int? modifiedBy;
  bool? isDelete;

  JobSeekerProfessionalResponse({
    this.id,
    this.jobSeekerProfile,
    this.type,
    this.mark,
    this.examDate,
    this.createdBy,
    this.modifiedBy,
    this.isDelete,
  });

  JobSeekerProfessionalResponse copyWith({
    int? id,
    int? jobSeekerProfile,
    String? type,
    String? mark,
    DateTime? examDate,
    int? createdBy,
    int? modifiedBy,
    bool? isDelete,
  }) =>
      JobSeekerProfessionalResponse(
        id: id ?? this.id,
        jobSeekerProfile: jobSeekerProfile ?? this.jobSeekerProfile,
        type: type ?? this.type,
        mark: mark ?? this.mark,
        examDate: examDate ?? this.examDate,
        createdBy: createdBy ?? this.createdBy,
        modifiedBy: modifiedBy ?? this.modifiedBy,
        isDelete: isDelete ?? this.isDelete,
      );

  factory JobSeekerProfessionalResponse.fromJson(Map<String, dynamic> json) =>
      JobSeekerProfessionalResponse(
        id: json["id"],
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
        "id": id,
        "job_seeker_profile": jobSeekerProfile,
        "type": type,
        "mark": mark,
        "exam_date":
            "${examDate!.year.toString().padLeft(4, '0')}-${examDate!.month.toString().padLeft(2, '0')}-${examDate!.day.toString().padLeft(2, '0')}",
        "created_by": createdBy,
        "modified_by": modifiedBy,
        "is_delete": isDelete,
      };
}
