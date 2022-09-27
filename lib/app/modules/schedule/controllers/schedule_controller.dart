import 'package:emeeting_flutter/app/data/models/meet_model.dart';
import 'package:emeeting_flutter/app/data/services/meet_service.dart';
import 'package:get/get.dart';

class ScheduleController extends GetxController {
  final count = 0.obs;
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

  Future<List<MeetModel>> fetchListMeet() async {
    return await MeetService().getSchedules();
  }
}
