import 'package:get/get.dart';

import '../../../data/models/meet_attendance_model.dart';
import '../../../data/services/meet_service.dart';
import '../../auth/controllers/authentication_manager.dart';

class SalaryController extends GetxController {
  final count = 0.obs;

  RxInt total = 0.obs;
  final AuthenticationManager _authenticationManager = Get.find();

  @override
  void onInit() async {
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
    total.value = 0;

    List<MeetAttendanceModel> list = await MeetService()
        .getAttendances(_authenticationManager.getToken().toString());

    countSalary(list);
    return list;
  }

  void countSalary(List<MeetAttendanceModel> list) {
    list.forEach((element) {
      var salarySplit = element.user!.title!.salary!.replaceAll('Rp', '');
      print(salarySplit);
      total.value += int.parse(salarySplit.replaceAll('.', ''));
    });
  }
}
