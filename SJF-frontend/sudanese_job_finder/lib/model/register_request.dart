import 'dart:convert';

RegisterRequest registerRequestFromJson(String str) =>
    RegisterRequest.fromJson(json.decode(str));

String registerRequestToJson(RegisterRequest data) =>
    json.encode(data.toJson());

class RegisterRequest {
  String? username;
  String? email;
  String? password;
  List<int>? groups;

  RegisterRequest({
    this.username,
    this.email,
    this.password,
    this.groups,
  });

  factory RegisterRequest.fromJson(Map<String, dynamic> json) =>
      RegisterRequest(
        username: json["username"],
        email: json["email"],
        password: json["password"],
        groups: json["groups"] == null
            ? []
            : List<int>.from(json["groups"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "email": email,
        "password": password,
        "groups":
            groups == null ? [] : List<dynamic>.from(groups!.map((x) => x)),
      };
}
