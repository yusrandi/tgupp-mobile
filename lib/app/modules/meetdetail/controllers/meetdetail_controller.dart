import 'dart:math';

import 'package:emeeting_flutter/app/data/models/meet_model.dart';
import 'package:emeeting_flutter/app/data/services/attendance_service.dart';
import 'package:emeeting_flutter/app/data/services/meet_service.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import '../../../cores/core_colors.dart';
import '../../../cores/core_strings.dart';
import '../../../routes/app_pages.dart';

enum Status { none, running, stopped, paused }

class MeetdetailController extends GetxController {
  final count = 0.obs;
  Rx<Status> status = Status.none.obs;

  final double latPos = -5.139467;
  final double lngPos = 119.452174;

  RxInt distance = 0.obs;
  String location = "location";

  @override
  void onInit() async {
    super.onInit();

    Position position = await _getGeoLocationPosition();
    print("[Location Lat: ${position.latitude} , Long: ${position.longitude} ");

    double distanceD = calculateDistance(position.latitude, position.longitude);
    location = "${position.latitude},${position.longitude}";
    print("${distanceD.round()} KM");

    distance.value = distanceD.round();
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

    String response = await AttendanceService().store(userId, meetId, location);

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

  Future<Position> _getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  double calculateDistance(lat1, lon1) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((latPos - lat1) * p) / 2 +
        c(lat1 * p) * c(latPos * p) * (1 - c((lngPos - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }
}
