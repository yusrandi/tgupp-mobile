import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'app/routes/app_pages.dart';

void main() async {
  await GetStorage.init();

  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "E Meeting Flutter",
      theme: ThemeData(fontFamily: "Muli"),
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
