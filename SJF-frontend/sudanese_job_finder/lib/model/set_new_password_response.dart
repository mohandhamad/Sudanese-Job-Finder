import 'dart:convert';

SetNewPasswordResponse setNewPasswordResponseFromJson(String str) =>
    SetNewPasswordResponse.fromJson(json.decode(str));

String setNewPasswordResponseToJson(SetNewPasswordResponse data) =>
    json.encode(data.toJson());

class SetNewPasswordResponse {
  String? password;
  String? confirmPassword;
  String? uidb64;
  String? token;

  SetNewPasswordResponse({
    this.password,
    this.confirmPassword,
    this.uidb64,
    this.token,
  });

  factory SetNewPasswordResponse.fromJson(Map<String, dynamic> json) =>
      SetNewPasswordResponse(
        password: json["password"],
        confirmPassword: json["confirm_password"],
        uidb64: json["uidb64"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "password": password,
        "confirm_password": confirmPassword,
        "uidb64": uidb64,
        "token": token,
      };
}
