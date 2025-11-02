import 'dart:convert';

List<JobSeekerQualificationsResponse> jobSeekerQualificationsResponseFromJson(
        String str) =>
    List<JobSeekerQualificationsResponse>.from(json
        .decode(str)
        .map((x) => JobSeekerQualificationsResponse.fromJson(x)));

String jobSeekerQualificationsResponseToJson(
        List<JobSeekerQualificationsResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class JobSeekerQualificationsResponse {
  int? id;
  int? jobSeekerProfile;
  String? degree;
  String? major;
  String? school;
  DateTime? graduationDate;
  String? gpa;
  String? grade;
  DateTime? startDate;
  DateTime? endDate;
  int? createdBy;
  int? modifiedBy;
  bool? isDelete;

  JobSeekerQualificationsResponse({
    this.id,
    this.jobSeekerProfile,
    this.degree,
    this.major,
    this.school,
    this.graduationDate,
    this.gpa,
    this.grade,
    this.startDate,
    this.endDate,
    this.createdBy,
    this.modifiedBy,
    this.isDelete,
  });

  JobSeekerQualificationsResponse copyWith({
    int? id,
    int? jobSeekerProfile,
    String? degree,
    String? major,
    String? school,
    DateTime? graduationDate,
    String? gpa,
    String? grade,
    DateTime? startDate,
    DateTime? endDate,
    int? createdBy,
    int? modifiedBy,
    bool? isDelete,
  }) =>
      JobSeekerQualificationsResponse(
        id: id ?? this.id,
        jobSeekerProfile: jobSeekerProfile ?? this.jobSeekerProfile,
        degree: degree ?? this.degree,
        major: major ?? this.major,
        school: school ?? this.school,
        graduationDate: graduationDate ?? this.graduationDate,
        gpa: gpa ?? this.gpa,
        grade: grade ?? this.grade,
        startDate: startDate ?? this.startDate,
        endDate: endDate ?? this.endDate,
        createdBy: createdBy ?? this.createdBy,
        modifiedBy: modifiedBy ?? this.modifiedBy,
        isDelete: isDelete ?? this.isDelete,
      );

  factory JobSeekerQualificationsResponse.fromJson(Map<String, dynamic> json) =>
      JobSeekerQualificationsResponse(
        id: json["id"],
        jobSeekerProfile: json["job_seeker_profile"],
        degree: json["degree"],
        major: json["major"],
        school: json["school"],
        graduationDate: json["graduation_date"] == null
            ? null
            : DateTime.parse(json["graduation_date"]),
        gpa: json["gpa"],
        grade: json["grade"],
        startDate: json["start_date"] == null
            ? null
            : DateTime.parse(json["start_date"]),
        endDate:
            json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
        createdBy: json["created_by"],
        modifiedBy: json["modified_by"],
        isDelete: json["is_delete"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "job_seeker_profile": jobSeekerProfile,
        "degree": degree,
        "major": major,
        "school": school,
        "graduation_date":
            "${graduationDate!.year.toString().padLeft(4, '0')}-${graduationDate!.month.toString().padLeft(2, '0')}-${graduationDate!.day.toString().padLeft(2, '0')}",
        "gpa": gpa,
        "grade": grade,
        "start_date":
            "${startDate!.year.toString().padLeft(4, '0')}-${startDate!.month.toString().padLeft(2, '0')}-${startDate!.day.toString().padLeft(2, '0')}",
        "end_date":
            "${endDate!.year.toString().padLeft(4, '0')}-${endDate!.month.toString().padLeft(2, '0')}-${endDate!.day.toString().padLeft(2, '0')}",
        "created_by": createdBy,
        "modified_by": modifiedBy,
        "is_delete": isDelete,
      };
}
