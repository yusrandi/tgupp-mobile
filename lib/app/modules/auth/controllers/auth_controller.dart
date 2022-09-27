import 'package:get/get.dart';

enum Status { none, running, stopped, paused }

class AuthController extends GetxController {
  Rx<Status> status = Status.none.obs;
  RxBool passwordVisible = false.obs;

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
}
