import 'dart:async';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'app/firebase/fcm/notification_helper.dart';
import 'app/firebase/services/local_notification_services.dart';
import 'app/routes/app_pages.dart';

@pragma('vm:entry-point')
Future<void> backGroundHandler(RemoteMessage msg) async {
  print("backGroundHandler");
  print(msg.data.toString());
  print(msg.notification!.title);
}

void main() async {
  await GetStorage.init();

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(backGroundHandler);

  LocalNotificationServices.initialize();
  LocalNotificationServices.requestPermissions();
  NotificationHelper.init();

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
