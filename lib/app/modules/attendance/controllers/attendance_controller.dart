import 'package:emeeting_flutter/app/data/models/meet_attendance_model.dart';
import 'package:emeeting_flutter/app/modules/auth/controllers/authentication_manager.dart';
import 'package:get/get.dart';

import '../../../data/services/meet_service.dart';

class AttendanceController extends GetxController {
  final count = 0.obs;
  final AuthenticationManager _authenticationManager = Get.find();
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;

  Future<List<MeetAttendanceModel>> fetchListMeetAttendance() async {
    return await MeetService()
        .getAttendances(_authenticationManager.getToken().toString());
  }
}
