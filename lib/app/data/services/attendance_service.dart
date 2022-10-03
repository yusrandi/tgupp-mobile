import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../configs/api.dart';

class AttendanceService extends GetConnect {
  Future<String> store(String userId, String meetId) async {
    final response =
        await http.post(Uri.parse(Api.instance.attendanceUrl), body: {
      "user_id": userId,
      "meet_id": meetId,
    });

    var data = json.decode(response.body);
    print(data);
    return data['responsecode'];
  }
}
