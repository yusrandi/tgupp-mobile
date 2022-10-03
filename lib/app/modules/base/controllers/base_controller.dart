import 'package:emeeting_flutter/app/modules/auth/controllers/authentication_manager.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';

class BaseController extends GetxController {
  final count = 1.obs;
  final AuthenticationManager _authenticationManager =
      Get.put(AuthenticationManager());

  final String TAG = "BaseController";

  @override
  void onInit() {
    super.onInit();
    print("[$TAG] ${_authenticationManager.getToken()}");

    if (_authenticationManager.getToken() == null) {
      Get.offAndToNamed(Routes.AUTH);
    }
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
  void setIndex(index) => count.value = index;
}
