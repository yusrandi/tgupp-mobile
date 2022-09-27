import 'package:get/get.dart';

import '../../../data/models/meet_attendance_model.dart';
import '../../../data/services/meet_service.dart';

class SalaryController extends GetxController {
  final count = 0.obs;

  RxInt total = 0.obs;

  @override
  void onInit() async {
    super.onInit();

    List<MeetAttendanceModel> list = await fetchListMeetAttendance();
    list.forEach((element) {
      var salarySplit = element.meet!.salary!.replaceAll('Rp', '');
      total.value += int.parse(salarySplit.replaceAll('.', ''));
    });
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
    return await MeetService().getAttendances('2');
  }
}
