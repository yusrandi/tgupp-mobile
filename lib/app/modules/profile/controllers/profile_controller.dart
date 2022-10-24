import 'dart:convert';

import 'package:get/get.dart';

import '../../../configs/api.dart';
import 'package:http/http.dart' as http;

import '../../../cores/core_colors.dart';
import '../../../cores/core_strings.dart';
import '../../../data/models/user_model.dart';
import '../../auth/controllers/authentication_manager.dart';

enum Status { none, running, stopped, paused }

class ProfileController extends GetxController {
  Rx<Status> status = Status.none.obs;
  final AuthenticationManager authenticationManager =
      Get.put(AuthenticationManager());

  final count = 0.obs;
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

  Future<UserModel> profileUser() async {
    status.value = Status.running;
    String id = authenticationManager.getToken().toString();
    var _response = await http.get(Uri.parse('${Api().profileUrl}/$id'));

    status.value = Status.none;

    var data = json.decode(_response.body);
    print(data['responsecode']);
    UserModel user = UserModel.fromJson(json.decode(_response.body)['user']);

    // login(user.id.toString());
    // _authManager.login(user.id.toString());

    // await Get.offAndToNamed(Routes.HOME);

    Get.snackbar(CoreStrings.appName, "Welcome ${user.fullname}",
        backgroundColor: CoreColor.whiteSoft,
        duration: const Duration(seconds: 2));
    return user;
  }
}
