import 'dart:convert';

List<CompanyProfileResponse> companyProfileResponseFromJson(String str) =>
    List<CompanyProfileResponse>.from(
        json.decode(str).map((x) => CompanyProfileResponse.fromJson(x)));

String companyProfileResponseToJson(List<CompanyProfileResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CompanyProfileResponse {
  int? id;
  String? companyName;
  String? image;
  String? mobile;
  String? description;
  String? webSite;
  dynamic createdBy;
  dynamic modifiedBy;
  bool? isDelete;

  CompanyProfileResponse({
    this.id,
    this.companyName,
    this.image,
    this.mobile,
    this.description,
    this.webSite,
    this.createdBy,
    this.modifiedBy,
    this.isDelete,
  });

  CompanyProfileResponse copyWith({
    int? id,
    int? user,
    String? companyName,
    String? image,
    String? mobile,
    String? description,
    String? webSite,
    dynamic createdBy,
    dynamic modifiedBy,
    bool? isDelete,
  }) =>
      CompanyProfileResponse(
        id: id ?? this.id,
        companyName: companyName ?? this.companyName,
        image: image ?? this.image,
        mobile: mobile ?? this.mobile,
        description: description ?? this.description,
        webSite: webSite ?? this.webSite,
        createdBy: createdBy ?? this.createdBy,
        modifiedBy: modifiedBy ?? this.modifiedBy,
        isDelete: isDelete ?? this.isDelete,
      );

  factory CompanyProfileResponse.fromJson(Map<String, dynamic> json) =>
      CompanyProfileResponse(
        id: json["id"],
        companyName: json["company_name"],
        image: json["image"],
        mobile: json["mobile"],
        description: json["description"],
        webSite: json["web_site"],
        createdBy: json["created_by"],
        modifiedBy: json["modified_by"],
        isDelete: json["is_delete"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "company_name": companyName,
        "image": image,
        "mobile": mobile,
        "description": description,
        "web_site": webSite,
        "created_by": createdBy,
        "modified_by": modifiedBy,
        "is_delete": isDelete,
      };
}
