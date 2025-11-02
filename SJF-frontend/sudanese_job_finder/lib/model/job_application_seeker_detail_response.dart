import 'dart:convert';

List<JobApplicationSeekerDetailResponse>
    jobApplicationSeekerDetailResponseFromJson(String str) =>
        List<JobApplicationSeekerDetailResponse>.from(json
            .decode(str)
            .map((x) => JobApplicationSeekerDetailResponse.fromJson(x)));

String jobApplicationSeekerDetailResponseToJson(
        List<JobApplicationSeekerDetailResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class JobApplicationSeekerDetailResponse {
  int? id;
  JobSeekerProfile? jobSeekerProfile;
  CompanyJob? companyJob;
  ApplicationStatus? applicationStatus;
  int? createdBy;
  int? modifiedBy;
  bool? isDelete;
  List<JobSeeker>? jobSeekerContact;
  List<JobSeekerExperienceCertificate>? jobSeekerExperienceCertificate;
  List<JobSeekerAcademicQualification>? jobSeekerAcademicQualifications;
  List<JobSeeker>? jobSeekerProfessionalCertificate;
  List<JobSeekerAttachment>? jobSeekerAttachment;

  JobApplicationSeekerDetailResponse({
    this.id,
    this.jobSeekerProfile,
    this.companyJob,
    this.applicationStatus,
    this.createdBy,
    this.modifiedBy,
    this.isDelete,
    this.jobSeekerContact,
    this.jobSeekerExperienceCertificate,
    this.jobSeekerAcademicQualifications,
    this.jobSeekerProfessionalCertificate,
    this.jobSeekerAttachment,
  });

  JobApplicationSeekerDetailResponse copyWith({
    int? id,
    JobSeekerProfile? jobSeekerProfile,
    CompanyJob? companyJob,
    ApplicationStatus? applicationStatus,
    int? createdBy,
    int? modifiedBy,
    bool? isDelete,
    List<JobSeeker>? jobSeekerContact,
    List<JobSeekerExperienceCertificate>? jobSeekerExperienceCertificate,
    List<JobSeekerAcademicQualification>? jobSeekerAcademicQualifications,
    List<JobSeeker>? jobSeekerProfessionalCertificate,
    List<JobSeekerAttachment>? jobSeekerAttachment,
  }) =>
      JobApplicationSeekerDetailResponse(
        id: id ?? this.id,
        jobSeekerProfile: jobSeekerProfile ?? this.jobSeekerProfile,
        companyJob: companyJob ?? this.companyJob,
        applicationStatus: applicationStatus ?? this.applicationStatus,
        createdBy: createdBy ?? this.createdBy,
        modifiedBy: modifiedBy ?? this.modifiedBy,
        isDelete: isDelete ?? this.isDelete,
        jobSeekerContact: jobSeekerContact ?? this.jobSeekerContact,
        jobSeekerExperienceCertificate: jobSeekerExperienceCertificate ??
            this.jobSeekerExperienceCertificate,
        jobSeekerAcademicQualifications: jobSeekerAcademicQualifications ??
            this.jobSeekerAcademicQualifications,
        jobSeekerProfessionalCertificate: jobSeekerProfessionalCertificate ??
            this.jobSeekerProfessionalCertificate,
        jobSeekerAttachment: jobSeekerAttachment ?? this.jobSeekerAttachment,
      );

  factory JobApplicationSeekerDetailResponse.fromJson(
          Map<String, dynamic> json) =>
      JobApplicationSeekerDetailResponse(
        id: json["id"],
        jobSeekerProfile: json["job_seeker_profile"] == null
            ? null
            : JobSeekerProfile.fromJson(json["job_seeker_profile"]),
        companyJob: json["company_job"] == null
            ? null
            : CompanyJob.fromJson(json["company_job"]),
        applicationStatus: json["application_status"] == null
            ? null
            : ApplicationStatus.fromJson(json["application_status"]),
        createdBy: json["created_by"],
        modifiedBy: json["modified_by"],
        isDelete: json["is_delete"],
        jobSeekerContact: json["job_seeker_contact"] == null
            ? []
            : List<JobSeeker>.from(
                json["job_seeker_contact"]!.map((x) => JobSeeker.fromJson(x))),
        jobSeekerExperienceCertificate:
            json["job_seeker_experience_certificate"] == null
                ? []
                : List<JobSeekerExperienceCertificate>.from(
                    json["job_seeker_experience_certificate"]!.map(
                        (x) => JobSeekerExperienceCertificate.fromJson(x))),
        jobSeekerAcademicQualifications:
            json["job_seeker_academic_qualifications"] == null
                ? []
                : List<JobSeekerAcademicQualification>.from(
                    json["job_seeker_academic_qualifications"]!.map(
                        (x) => JobSeekerAcademicQualification.fromJson(x))),
        jobSeekerProfessionalCertificate:
            json["job_seeker_professional_certificate"] == null
                ? []
                : List<JobSeeker>.from(
                    json["job_seeker_professional_certificate"]!
                        .map((x) => JobSeeker.fromJson(x))),
        jobSeekerAttachment: json["job_seeker_attachment"] == null
            ? []
            : List<JobSeekerAttachment>.from(json["job_seeker_attachment"]!
                .map((x) => JobSeekerAttachment.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "job_seeker_profile": jobSeekerProfile?.toJson(),
        "company_job": companyJob?.toJson(),
        "application_status": applicationStatus?.toJson(),
        "created_by": createdBy,
        "modified_by": modifiedBy,
        "is_delete": isDelete,
        "job_seeker_contact": jobSeekerContact == null
            ? []
            : List<dynamic>.from(jobSeekerContact!.map((x) => x.toJson())),
        "job_seeker_experience_certificate":
            jobSeekerExperienceCertificate == null
                ? []
                : List<dynamic>.from(
                    jobSeekerExperienceCertificate!.map((x) => x.toJson())),
        "job_seeker_academic_qualifications":
            jobSeekerAcademicQualifications == null
                ? []
                : List<dynamic>.from(
                    jobSeekerAcademicQualifications!.map((x) => x.toJson())),
        "job_seeker_professional_certificate":
            jobSeekerProfessionalCertificate == null
                ? []
                : List<dynamic>.from(
                    jobSeekerProfessionalCertificate!.map((x) => x.toJson())),
        "job_seeker_attachment": jobSeekerAttachment == null
            ? []
            : List<dynamic>.from(jobSeekerAttachment!.map((x) => x.toJson())),
      };
}

class ApplicationStatus {
  int? id;
  String? description;
  int? createdBy;
  int? modifiedBy;
  bool? isDelete;

  ApplicationStatus({
    this.id,
    this.description,
    this.createdBy,
    this.modifiedBy,
    this.isDelete,
  });

  ApplicationStatus copyWith({
    int? id,
    String? description,
    int? createdBy,
    int? modifiedBy,
    bool? isDelete,
  }) =>
      ApplicationStatus(
        id: id ?? this.id,
        description: description ?? this.description,
        createdBy: createdBy ?? this.createdBy,
        modifiedBy: modifiedBy ?? this.modifiedBy,
        isDelete: isDelete ?? this.isDelete,
      );

  factory ApplicationStatus.fromJson(Map<String, dynamic> json) =>
      ApplicationStatus(
        id: json["id"],
        description: json["description"],
        createdBy: json["created_by"],
        modifiedBy: json["modified_by"],
        isDelete: json["is_delete"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "description": description,
        "created_by": createdBy,
        "modified_by": modifiedBy,
        "is_delete": isDelete,
      };
}

class CompanyJob {
  int? id;
  int? companyProfile;
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

  CompanyJob({
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
  });

  CompanyJob copyWith({
    int? id,
    int? companyProfile,
    String? jobTitle,
    String? jobType,
    String? jobField,
    String? skills,
    String? expLevel,
    String? jobDescription,
    String? salary,
    DateTime? deadline,
    int? createdBy,
    int? modifiedBy,
    bool? isDelete,
  }) =>
      CompanyJob(
        id: id ?? this.id,
        companyProfile: companyProfile ?? this.companyProfile,
        jobTitle: jobTitle ?? this.jobTitle,
        jobType: jobType ?? this.jobType,
        jobField: jobField ?? this.jobField,
        skills: skills ?? this.skills,
        expLevel: expLevel ?? this.expLevel,
        jobDescription: jobDescription ?? this.jobDescription,
        salary: salary ?? this.salary,
        deadline: deadline ?? this.deadline,
        createdBy: createdBy ?? this.createdBy,
        modifiedBy: modifiedBy ?? this.modifiedBy,
        isDelete: isDelete ?? this.isDelete,
      );

  factory CompanyJob.fromJson(Map<String, dynamic> json) => CompanyJob(
        id: json["id"],
        companyProfile: json["company_profile"],
        jobTitle: json["job_title"],
        jobType: json["job_type"],
        jobField: json["job_field"],
        skills: json["skills"],
        expLevel: json["exp_level"],
        jobDescription: json["job_description"],
        salary: json["salary"],
        deadline:
            json["end_at"] == null ? null : DateTime.parse(json["end_at"]),
        createdBy: json["created_by"],
        modifiedBy: json["modified_by"],
        isDelete: json["is_delete"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "company_profile": companyProfile,
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
      };
}

class JobSeekerAcademicQualification {
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

  JobSeekerAcademicQualification({
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

  JobSeekerAcademicQualification copyWith({
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
      JobSeekerAcademicQualification(
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

  factory JobSeekerAcademicQualification.fromJson(Map<String, dynamic> json) =>
      JobSeekerAcademicQualification(
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

class JobSeekerAttachment {
  int? id;
  int? jobSeekerProfile;
  String? jobSeekerAttachmentType;
  String? fileData;
  int? createdBy;
  int? modifiedBy;
  bool? isDelete;

  JobSeekerAttachment({
    this.id,
    this.jobSeekerProfile,
    this.jobSeekerAttachmentType,
    this.fileData,
    this.createdBy,
    this.modifiedBy,
    this.isDelete,
  });

  JobSeekerAttachment copyWith({
    int? id,
    int? jobSeekerProfile,
    String? jobSeekerAttachmentType,
    String? fileData,
    int? createdBy,
    int? modifiedBy,
    bool? isDelete,
  }) =>
      JobSeekerAttachment(
        id: id ?? this.id,
        jobSeekerProfile: jobSeekerProfile ?? this.jobSeekerProfile,
        jobSeekerAttachmentType:
            jobSeekerAttachmentType ?? this.jobSeekerAttachmentType,
        fileData: fileData ?? this.fileData,
        createdBy: createdBy ?? this.createdBy,
        modifiedBy: modifiedBy ?? this.modifiedBy,
        isDelete: isDelete ?? this.isDelete,
      );

  factory JobSeekerAttachment.fromJson(Map<String, dynamic> json) =>
      JobSeekerAttachment(
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

class JobSeeker {
  int? id;
  int? jobSeekerProfile;
  String? type;
  String? contactNumber;
  int? createdBy;
  int? modifiedBy;
  bool? isDelete;
  String? mark;
  DateTime? examDate;

  JobSeeker({
    this.id,
    this.jobSeekerProfile,
    this.type,
    this.contactNumber,
    this.createdBy,
    this.modifiedBy,
    this.isDelete,
    this.mark,
    this.examDate,
  });

  JobSeeker copyWith({
    int? id,
    int? jobSeekerProfile,
    String? type,
    String? contactNumber,
    int? createdBy,
    int? modifiedBy,
    bool? isDelete,
    String? mark,
    DateTime? examDate,
  }) =>
      JobSeeker(
        id: id ?? this.id,
        jobSeekerProfile: jobSeekerProfile ?? this.jobSeekerProfile,
        type: type ?? this.type,
        contactNumber: contactNumber ?? this.contactNumber,
        createdBy: createdBy ?? this.createdBy,
        modifiedBy: modifiedBy ?? this.modifiedBy,
        isDelete: isDelete ?? this.isDelete,
        mark: mark ?? this.mark,
        examDate: examDate ?? this.examDate,
      );

  factory JobSeeker.fromJson(Map<String, dynamic> json) => JobSeeker(
        id: json["id"],
        jobSeekerProfile: json["job_seeker_profile"],
        type: json["type"],
        contactNumber: json["contact_number"],
        createdBy: json["created_by"],
        modifiedBy: json["modified_by"],
        isDelete: json["is_delete"],
        mark: json["mark"],
        examDate: json["exam_date"] == null
            ? null
            : DateTime.parse(json["exam_date"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "job_seeker_profile": jobSeekerProfile,
        "type": type,
        "contact_number": contactNumber,
        "created_by": createdBy,
        "modified_by": modifiedBy,
        "is_delete": isDelete,
        "mark": mark,
        "exam_date":
            "${examDate!.year.toString().padLeft(4, '0')}-${examDate!.month.toString().padLeft(2, '0')}-${examDate!.day.toString().padLeft(2, '0')}",
      };
}

class JobSeekerExperienceCertificate {
  int? id;
  int? jobSeekerProfile;
  String? experienceRole;
  DateTime? startDate;
  DateTime? endDate;
  String? jobDuties;
  String? implementedProjects;
  int? createdBy;
  int? modifiedBy;
  bool? isDelete;

  JobSeekerExperienceCertificate({
    this.id,
    this.jobSeekerProfile,
    this.experienceRole,
    this.startDate,
    this.endDate,
    this.jobDuties,
    this.implementedProjects,
    this.createdBy,
    this.modifiedBy,
    this.isDelete,
  });

  JobSeekerExperienceCertificate copyWith({
    int? id,
    int? jobSeekerProfile,
    String? experienceRole,
    DateTime? startDate,
    DateTime? endDate,
    String? jobDuties,
    String? implementedProjects,
    int? createdBy,
    int? modifiedBy,
    bool? isDelete,
  }) =>
      JobSeekerExperienceCertificate(
        id: id ?? this.id,
        jobSeekerProfile: jobSeekerProfile ?? this.jobSeekerProfile,
        experienceRole: experienceRole ?? this.experienceRole,
        startDate: startDate ?? this.startDate,
        endDate: endDate ?? this.endDate,
        jobDuties: jobDuties ?? this.jobDuties,
        implementedProjects: implementedProjects ?? this.implementedProjects,
        createdBy: createdBy ?? this.createdBy,
        modifiedBy: modifiedBy ?? this.modifiedBy,
        isDelete: isDelete ?? this.isDelete,
      );

  factory JobSeekerExperienceCertificate.fromJson(Map<String, dynamic> json) =>
      JobSeekerExperienceCertificate(
        id: json["id"],
        jobSeekerProfile: json["job_seeker_profile"],
        experienceRole: json["experience_role"],
        startDate: json["start_date"] == null
            ? null
            : DateTime.parse(json["start_date"]),
        endDate:
            json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
        jobDuties: json["job_duties"],
        implementedProjects: json["implemented_projects"],
        createdBy: json["created_by"],
        modifiedBy: json["modified_by"],
        isDelete: json["is_delete"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "job_seeker_profile": jobSeekerProfile,
        "experience_role": experienceRole,
        "start_date":
            "${startDate!.year.toString().padLeft(4, '0')}-${startDate!.month.toString().padLeft(2, '0')}-${startDate!.day.toString().padLeft(2, '0')}",
        "end_date":
            "${endDate!.year.toString().padLeft(4, '0')}-${endDate!.month.toString().padLeft(2, '0')}-${endDate!.day.toString().padLeft(2, '0')}",
        "job_duties": jobDuties,
        "implemented_projects": implementedProjects,
        "created_by": createdBy,
        "modified_by": modifiedBy,
        "is_delete": isDelete,
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
  List<String>? skills; // Add the skills field

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
    this.skills, // Initialize the skills field
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
    List<String>? skills, // Add the skills field to the copyWith method
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
        skills: skills ?? this.skills, // Initialize the skills field
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
        "birth_date":
            "${birthDate!.year.toString().padLeft(4, '0')}-${birthDate!.month.toString().padLeft(2, '0')}-${birthDate!.day.toString().padLeft(2, '0')}",
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
