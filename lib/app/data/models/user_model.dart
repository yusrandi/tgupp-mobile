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
    this.titleId,
    this.employmentId,
    this.title,
  });

  int? id;
  String? fullname;
  String? image;
  String? email;
  String? isActive;
  String? roleId;
  String? titleId;
  String? employmentId;
  Title? title;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        fullname: json["fullname"],
        image: json["image"],
        email: json["email"],
        isActive: json["is_active"].toString(),
        roleId: json["role_id"].toString(),
        titleId: json["title_id"].toString(),
        employmentId: json["employment_id"].toString(),
        title: Title.fromJson(json["title"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "fullname": fullname,
        "image": image,
        "email": email,
        "is_active": isActive,
        "role_id": roleId,
        "title_id": titleId,
        "employment_id": employmentId,
        "title": title!.toJson(),
      };
}

class Title {
  Title({
    this.id,
    this.name,
    this.salary,
  });

  int? id;
  String? name;
  String? salary;

  factory Title.fromJson(Map<String, dynamic> json) => Title(
        id: json["id"],
        name: json["name"],
        salary: json["salary"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "salary": salary,
      };
}
