// To parse this JSON data, do
//
//     final meetModel = meetModelFromJson(jsonString);

import 'dart:convert';

import 'package:emeeting_flutter/app/data/models/meet_attendance_model.dart';
import 'package:emeeting_flutter/app/data/models/meet_result_model.dart';

class MeetModel {
  MeetModel({
    this.id,
    this.barcode,
    this.name,
    this.begin,
    this.end,
    this.place,
    this.status,
    this.salary,
    this.meetResults,
    this.meetAttendances,
  });

  int? id;
  String? barcode;
  String? name;
  String? begin;
  String? end;
  String? place;
  int? status;
  String? salary;
  List<MeetResultModel>? meetResults = [];
  List<MeetAttendanceModel>? meetAttendances = [];

  factory MeetModel.fromJson(Map<String, dynamic> json) => MeetModel(
        id: json["id"],
        barcode: json["barcode"],
        name: json["name"],
        begin: json["begin"],
        end: json["end"],
        place: json["place"],
        status: json["status"],
        salary: json["salary"],
        meetResults: json["meet_results"] != null
            ? List<MeetResultModel>.from(
                json["meet_results"].map((x) => MeetResultModel.fromJson(x)))
            : [],
        meetAttendances: json["meet_attendances"] != null
            ? List<MeetAttendanceModel>.from(json["meet_attendances"]
                .map((x) => MeetAttendanceModel.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "barcode": barcode,
        "name": name,
        "begin": begin,
        "end": end,
        "place": place,
        "status": status,
        "salary": salary,
        "meet_results": List<dynamic>.from(meetResults!.map((x) => x.toJson())),
        "meet_attendances":
            List<dynamic>.from(meetAttendances!.map((x) => x.toJson())),
      };
}
