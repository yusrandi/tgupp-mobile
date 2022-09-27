import 'package:emeeting_flutter/app/data/models/meet_model.dart';

class MeetAttendanceModel {
  MeetAttendanceModel(
      {this.id, this.time, this.status, this.userId, this.meetId, this.meet});

  int? id;
  String? time;
  String? status;
  int? userId;
  int? meetId;
  MeetModel? meet;

  factory MeetAttendanceModel.fromJson(Map<String, dynamic> json) =>
      MeetAttendanceModel(
        id: json["id"],
        time: json["time"],
        status: json["status"],
        userId: json["user_id"],
        meetId: json["meet_id"],
        meet: json["meet"] != null
            ? MeetModel.fromJson(json["meet"])
            : MeetModel(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "time": time,
        "status": status,
        "user_id": userId,
        "meet_id": meetId,
        "meet": meet!.toJson(),
      };
}
