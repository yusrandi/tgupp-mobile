// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    this.id,
    this.fullname,
    this.image,
    this.email,
    this.isActive,
    this.roleId,
    this.employmentId,
  });

  int? id;
  String? fullname;
  String? image;
  String? email;
  String? isActive;
  String? roleId;
  String? employmentId;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        fullname: json["fullname"],
        image: json["image"],
        email: json["email"],
        isActive: json["is_active"],
        roleId: json["role_id"],
        employmentId: json["employment_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "fullname": fullname,
        "image": image,
        "email": email,
        "is_active": isActive,
        "role_id": roleId,
        "employment_id": employmentId,
      };
}
