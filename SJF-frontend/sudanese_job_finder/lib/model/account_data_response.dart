import 'dart:convert';

AccountDataResponse accountDataResponseFromJson(String str) =>
    AccountDataResponse.fromJson(json.decode(str));

String accountDataResponseToJson(AccountDataResponse data) =>
    json.encode(data.toJson());

class AccountDataResponse {
  int? id;
  String? username;
  String? email;
  bool? isVerified;
  String? uniqueIdentity;
  List<int>? groups;

  AccountDataResponse({
    this.id,
    this.username,
    this.email,
    this.isVerified,
    this.uniqueIdentity,
    this.groups,
  });

  factory AccountDataResponse.fromJson(Map<String, dynamic> json) =>
      AccountDataResponse(
        id: json["id"],
        username: json["username"],
        email: json["email"],
        isVerified: json["is_verified"],
        uniqueIdentity: json["unique_identity"],
        groups: json["groups"] == null
            ? []
            : List<int>.from(json["groups"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "email": email,
        "is_verified": isVerified,
        "unique_identity": uniqueIdentity,
        "groups":
            groups == null ? [] : List<dynamic>.from(groups!.map((x) => x)),
      };
}
