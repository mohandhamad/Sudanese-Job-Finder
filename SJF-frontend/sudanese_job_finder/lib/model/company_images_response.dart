import 'dart:convert';

List<CompanyImagesResponse> companyImagesResponseFromJson(String str) =>
    List<CompanyImagesResponse>.from(
        json.decode(str).map((x) => CompanyImagesResponse.fromJson(x)));

String companyImagesResponseToJson(List<CompanyImagesResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CompanyImagesResponse {
  int? id;
  int? companyProfile;
  String? title;
  String? description;
  String? image;
  String? uniqueIdentity;
  DateTime? createdAt;
  DateTime? modifiedAt;
  int? createdBy;
  int? modifiedBy;
  bool? isDelete;

  CompanyImagesResponse({
    this.id,
    this.companyProfile,
    this.title,
    this.description,
    this.image,
    this.uniqueIdentity,
    this.createdAt,
    this.modifiedAt,
    this.createdBy,
    this.modifiedBy,
    this.isDelete,
  });

  CompanyImagesResponse copyWith({
    int? id,
    int? companyProfile,
    String? title,
    String? description,
    String? image,
    String? uniqueIdentity,
    DateTime? createdAt,
    DateTime? modifiedAt,
    int? createdBy,
    int? modifiedBy,
    bool? isDelete,
  }) =>
      CompanyImagesResponse(
        id: id ?? this.id,
        companyProfile: companyProfile ?? this.companyProfile,
        title: title ?? this.title,
        description: description ?? this.description,
        image: image ?? this.image,
        uniqueIdentity: uniqueIdentity ?? this.uniqueIdentity,
        createdAt: createdAt ?? this.createdAt,
        modifiedAt: modifiedAt ?? this.modifiedAt,
        createdBy: createdBy ?? this.createdBy,
        modifiedBy: modifiedBy ?? this.modifiedBy,
        isDelete: isDelete ?? this.isDelete,
      );

  factory CompanyImagesResponse.fromJson(Map<String, dynamic> json) =>
      CompanyImagesResponse(
        id: json["id"],
        companyProfile: json["company_profile"],
        title: json["title"],
        description: json["description"],
        image: json["image"],
        uniqueIdentity: json["unique_identity"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        modifiedAt: json["modified_at"] == null
            ? null
            : DateTime.parse(json["modified_at"]),
        createdBy: json["created_by"],
        modifiedBy: json["modified_by"],
        isDelete: json["is_delete"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "company_profile": companyProfile,
        "title": title,
        "description": description,
        "image": image,
        "unique_identity": uniqueIdentity,
        "created_at": createdAt?.toIso8601String(),
        "modified_at": modifiedAt?.toIso8601String(),
        "created_by": createdBy,
        "modified_by": modifiedBy,
        "is_delete": isDelete,
      };
}
