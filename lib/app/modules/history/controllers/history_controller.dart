import 'package:get/get.dart';

import '../../../data/models/meet_model.dart';
import '../../../data/services/meet_service.dart';

class HistoryController extends GetxController {
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
    return await MeetService().getHistories();
  }
}
