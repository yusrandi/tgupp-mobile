import 'dart:convert';

import 'package:emeeting_flutter/app/configs/api.dart';
import 'package:emeeting_flutter/app/data/models/meet_model.dart';
import 'package:emeeting_flutter/app/data/models/user_model.dart';
import 'package:emeeting_flutter/app/data/services/attendance_service.dart';
import 'package:emeeting_flutter/app/data/services/meet_service.dart';

import 'package:http/http.dart' as http;

void main() async {
  var _response = await http.post(Uri.parse(Api().loginUrl), body: {
    "email": "user@gmail.com",
    "password": "87654321",
  });

  var data = json.decode(_response.body);
  print(data);
  if (data['responsecode'] == '1') {
    UserModel user = UserModel.fromJson(json.decode(_response.body)['user']);

    // login(user.id.toString());

    // await Get.offAndToNamed(Routes.HOME);
  }
}
