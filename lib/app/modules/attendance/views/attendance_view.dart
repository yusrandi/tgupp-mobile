import 'package:emeeting_flutter/app/cores/core_colors.dart';
import 'package:emeeting_flutter/app/data/models/meet_attendance_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';

import '../../../cores/core_images.dart';
import '../../../cores/core_styles.dart';
import '../controllers/attendance_controller.dart';

class AttendanceView extends GetView<AttendanceController> {
  AttendanceView({Key? key}) : super(key: key);
  final AttendanceController attendanceController =
      Get.put(AttendanceController());
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 50),
            Row(
              children: [
                Image.asset(CoreImages.logoSulselImages, height: 50),
                const SizedBox(width: 16),
                Text(
                  'Attendance Meeting',
                  style: CoreStyles.uTitle,
                ),
              ],
            ),
            const SizedBox(height: 16),
            FutureBuilder<List<MeetAttendanceModel>>(
              future: attendanceController.fetchListMeetAttendance(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                List<MeetAttendanceModel> data = snapshot.data!;

                return Container(
                  child: MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        primary: false,
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          MeetAttendanceModel model = data[index];
                          return itemList(size, model);
                        }),
                  ),
                );
              },
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  itemList(Size size, MeetAttendanceModel model) {
    var splitDate = model.time!.split(" ");
    return Container(
      child: Row(
        children: [
          Column(
            children: [
              Text(
                splitDate[1],
                style: CoreStyles.uTitle.copyWith(color: CoreColor.primary),
              ),
              Text(
                splitDate[0],
                style: CoreStyles.uHeading3.copyWith(color: Colors.green),
              ),
            ],
          ),
          Text(splitDate[2],
              style: CoreStyles.uHeading3.copyWith(color: CoreColor.primary)),
          const SizedBox(width: 16),
          Container(
            width: 3,
            height: 130,
            color: Colors.grey,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.meet!.name!,
                  style: CoreStyles.uSubTitle,
                ),
                const SizedBox(height: 16),
                Text('${model.meet!.begin} - ${model.meet!.end}',
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold)),
                Container(
                  margin: const EdgeInsets.only(top: 8),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 26, vertical: 8),
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(16)),
                  child: const Text('anda hadir',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold)),
                ),
                const Divider(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
