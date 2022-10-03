import 'package:emeeting_flutter/app/data/models/meet_model.dart';
import 'package:emeeting_flutter/app/data/services/attendance_service.dart';
import 'package:emeeting_flutter/app/data/services/meet_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../cores/core_colors.dart';
import '../../../cores/core_strings.dart';
import '../../../routes/app_pages.dart';

enum Status { none, running, stopped, paused }

class MeetdetailController extends GetxController {
  final count = 0.obs;
  Rx<Status> status = Status.none.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;

  Future<MeetModel> getMeet(String barcode) async {
    return await MeetService().getMeet(barcode);
  }

  Future<String> storeAttendance(String userId, String meetId) async {
    status.value = Status.running;

    String response = await AttendanceService().store(userId, meetId);

    status.value = Status.none;

    if (response == '1') {
      Get.snackbar(CoreStrings.appName, "Terima kasih telah mengisi kehadiran",
          backgroundColor: CoreColor.whiteSoft,
          duration: const Duration(seconds: 2));
    } else {
      Get.snackbar(CoreStrings.appName, "Maaf, anda telah mengisi kehadiran",
          backgroundColor: CoreColor.whiteSoft,
          duration: const Duration(seconds: 2));
    }

    Get.offAndToNamed(Routes.BASE);

    return response;
  }
}
