import 'package:emeeting_flutter/app/data/models/meet_model.dart';
import 'package:emeeting_flutter/app/data/models/user_model.dart';

class MeetAttendanceModel {
  MeetAttendanceModel(
      {this.id,
      this.time,
      this.status,
      this.userId,
      this.meetId,
      this.meet,
      this.user});

  int? id;
  String? time;
  String? status;
  String? userId;
  String? meetId;
  MeetModel? meet;
  UserModel? user;

  factory MeetAttendanceModel.fromJson(Map<String, dynamic> json) =>
      MeetAttendanceModel(
        id: json["id"],
        time: json["time"],
        status: json["status"],
        userId: json["user_id"].toString(),
        meetId: json["meet_id"].toString(),
        meet: json["meet"] != null
            ? MeetModel.fromJson(json["meet"])
            : MeetModel(),
        user: json["user"] != null
            ? UserModel.fromJson(json["user"])
            : UserModel(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "time": time,
        "status": status,
        "user_id": userId,
        "meet_id": meetId,
        "meet": meet!.toJson(),
        "user": user!.toJson(),
      };
}
