import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

import '../../../configs/api.dart';
import '../../../cores/core_colors.dart';
import '../../../cores/core_strings.dart';
import '../../../data/models/user_model.dart';
import 'authentication_manager.dart';
import 'package:http/http.dart' as http;

enum Status { none, running, stopped, paused }

class AuthController extends GetxController {
  Rx<Status> status = Status.none.obs;
  RxBool passwordVisible = false.obs;
  late final AuthenticationManager _authManager =
      Get.put(AuthenticationManager());

  String token = "token";

  final count = 0.obs;
  @override
  void onInit() async {
    super.onInit();

    token = await getMessagingToken();
    print(token);
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

  Future<String> getMessagingToken() async {
    String token = "";

    await FirebaseMessaging.instance
        .requestPermission()
        .timeout(Duration(seconds: 5))
        .then((value) {
      print(
          'SignForm.getMessagingToken() requestPermission result is ${value.authorizationStatus}');
    }).catchError((e) {
      print(
          'SignForm.getMessagingToken() requestPermission error: ${e.toString()}');

      Get.snackbar(CoreStrings.appName, "Terjadi kesalahan perijinan",
          backgroundColor: CoreColor.whiteSoft,
          duration: const Duration(seconds: 2));
    });

    await FirebaseMessaging.instance.getToken().then((value) {
      print(' SignForm.getMessagingToken() token is $value');
      token = value!;
    }).catchError((e) {
      print('SignForm.getMessagingToken() getToken error: $e');
      Get.snackbar(CoreStrings.appName, "Terjadi Kesalahan Generate Token",
          backgroundColor: CoreColor.whiteSoft,
          duration: const Duration(seconds: 2));
    });

    return token;
  }

  Future<String> loginUser(String email, String password) async {
    status.value = Status.running;
    var _response = await http.post(Uri.parse(Api().loginUrl), body: {
      "email": email,
      "password": password,
      "token": token,
    });

    status.value = Status.none;

    var data = json.decode(_response.body);
    print(data['responsecode']);
    if (data['responsecode'] == '1') {
      UserModel user = UserModel.fromJson(json.decode(_response.body)['user']);

      // login(user.id.toString());
      _authManager.login(user.id.toString());

      // await Get.offAndToNamed(Routes.HOME);
    }

    Get.snackbar(CoreStrings.appName, "${data['responsemsg']}",
        backgroundColor: CoreColor.whiteSoft,
        duration: const Duration(seconds: 2));
    return _response.body;
  }
}
