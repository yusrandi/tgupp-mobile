import 'package:emeeting_flutter/app/modules/attendance/views/attendance_view.dart';
import 'package:emeeting_flutter/app/modules/history/views/history_view.dart';
import 'package:emeeting_flutter/app/modules/home/views/home_view.dart';
import 'package:emeeting_flutter/app/modules/salary/views/salary_view.dart';
import 'package:emeeting_flutter/app/modules/scanner/views/scanner_view.dart';
import 'package:emeeting_flutter/app/modules/schedule/views/schedule_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';

import '../../../cores/core_colors.dart';
import '../controllers/base_controller.dart';

class BaseView extends GetView<BaseController> {
  BaseView({Key? key}) : super(key: key);
  final BaseController c = Get.put(BaseController());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: CoreColor.greyColor2,
      body: Stack(
        children: [
          SizedBox(
            width: size.width,
            height: size.height,
            child: Obx(() => c.count.value == 0
                ? ScannerView()
                : c.count.value == 1
                    ? ScheduleView()
                    : c.count.value == 2
                        ? HistoryView()
                        : c.count.value == 3
                            ? AttendanceView()
                            : c.count.value == 4
                                ? SalaryView()
                                : HomeView()),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.all(8),
              width: double.infinity,
              height: 90,
              child: Stack(
                children: [
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    top: 30,
                    child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15))),
                  ),
                  Positioned(
                      bottom: 8,
                      left: 16,
                      right: 16,
                      top: 0,
                      child: _tabItem()),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _tabItem() {
    return Obx((() => Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
                child: _listItem("schedule", "assets/icons/home.svg", 30, 1)),
            Expanded(
              child: _listItem("history", "assets/icons/schedule.svg", 30, 2),
            ),
            Expanded(
                child: GestureDetector(
              onTap: (() => c.setIndex(0)),
              child: Container(
                decoration: BoxDecoration(
                    color: CoreColor.primary, shape: BoxShape.circle),
                padding: EdgeInsets.all(10),
                child: SvgPicture.asset(
                  "assets/icons/qr-code.svg",
                  color: Colors.white,
                  height: 50,
                ),
              ),
            )),
            Expanded(
                child: _listItem("attendance", "assets/icons/list.svg", 30, 3)),
            Expanded(
                child: _listItem("salary", "assets/icons/setting.svg", 30, 4))
          ],
        )));
  }

  _listItem(String title, String iconAsset, double heightIcon, int index) {
    return GestureDetector(
      onTap: () => c.setIndex(index),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            iconAsset,
            color: c.count.value == index ? CoreColor.primary : Colors.grey,
            height: heightIcon,
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: c.count.value == index ? CoreColor.primary : Colors.grey,
                fontSize: 12),
          )
        ],
      ),
    );
  }
}
