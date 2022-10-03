import 'package:get/get.dart';

import '../controllers/meetdetail_controller.dart';

class MeetdetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MeetdetailController>(
      () => MeetdetailController(),
    );
  }
}
