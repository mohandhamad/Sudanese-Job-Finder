import 'dart:convert';

CompanyImagesRequest companyImagesRequestFromJson(String str) =>
    CompanyImagesRequest.fromJson(json.decode(str));

String companyImagesRequestToJson(CompanyImagesRequest data) =>
    json.encode(data.toJson());

class CompanyImagesRequest {
  int? companyProfile;
  String? title;
  String? description;
  String? image;
  int? createdBy;
  bool? isDelete;

  CompanyImagesRequest({
    this.companyProfile,
    this.title,
    this.description,
    this.image,
    this.createdBy,
    this.isDelete,
  });

  CompanyImagesRequest copyWith({
    int? companyProfile,
    String? title,
    String? description,
    String? image,
    int? createdBy,
    bool? isDelete,
  }) =>
      CompanyImagesRequest(
        companyProfile: companyProfile ?? this.companyProfile,
        title: title ?? this.title,
        description: description ?? this.description,
        image: image ?? this.image,
        createdBy: createdBy ?? this.createdBy,
        isDelete: isDelete ?? this.isDelete,
      );

  factory CompanyImagesRequest.fromJson(Map<String, dynamic> json) =>
      CompanyImagesRequest(
        companyProfile: json["company_profile"],
        title: json["title"],
        description: json["description"],
        image: json["image"],
        createdBy: json["created_by"],
        isDelete: json["is_delete"],
      );

  Map<String, dynamic> toJson() => {
        "company_profile": companyProfile,
        "title": title,
        "description": description,
        "image": image,
        "created_by": createdBy,
        "is_delete": isDelete,
      };
}
