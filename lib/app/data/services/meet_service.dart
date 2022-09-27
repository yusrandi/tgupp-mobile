import 'dart:convert';

import 'package:emeeting_flutter/app/data/models/meet_attendance_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../configs/api.dart';
import '../models/meet_model.dart';

class MeetService extends GetConnect {
  Future<List<MeetModel>> getSchedules() async {
    final response = await http.get(Uri.parse(Api.instance.scheduleUrl));

    List data = (json.decode(response.body) as Map<String, dynamic>)["meet"];
    print(data);
    if (data.isEmpty) {
      return [];
    } else {
      return data.map((e) => MeetModel.fromJson(e)).toList();
    }
  }

  Future<List<MeetModel>> getHistories() async {
    final response = await http.get(Uri.parse(Api.instance.historyUrl));

    List data = (json.decode(response.body) as Map<String, dynamic>)["meet"];
    print(data);
    if (data.isEmpty) {
      return [];
    } else {
      return data.map((e) => MeetModel.fromJson(e)).toList();
    }
  }

  Future<List<MeetAttendanceModel>> getAttendances(String userId) async {
    final response =
        await http.get(Uri.parse('${Api.instance.attendanceUrl}/$userId'));

    List data = (json.decode(response.body) as Map<String, dynamic>)["data"];
    print(data);
    if (data.isEmpty) {
      return [];
    } else {
      return data.map((e) => MeetAttendanceModel.fromJson(e)).toList();
    }
  }
}
