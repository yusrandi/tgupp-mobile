import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';

import '../../../cores/core_images.dart';
import '../../../cores/core_styles.dart';
import '../../../cores/helper/currency.dart';
import '../../../data/models/meet_attendance_model.dart';
import '../controllers/salary_controller.dart';

class SalaryView extends GetView<SalaryController> {
  SalaryView({Key? key}) : super(key: key);

  SalaryController salaryController = Get.put(SalaryController());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
                width: size.width,
                margin: const EdgeInsets.only(bottom: 106),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16), color: Colors.red),
                child: Obx(
                  () => Text(
                      CurrencyFormat.convertToIdr(
                          salaryController.total.value, 2),
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold)),
                )),
          ),
          SingleChildScrollView(
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
                      'Salary Meeting',
                      style: CoreStyles.uTitle,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                FutureBuilder<List<MeetAttendanceModel>>(
                  future: salaryController.fetchListMeetAttendance(),
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
                            physics: const NeverScrollableScrollPhysics(),
                            primary: false,
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              MeetAttendanceModel model = data[index];

                              return Container(
                                margin: const EdgeInsets.only(bottom: 16),
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    color: Colors.white),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(model.meet!.name!,
                                        style: TextStyle(
                                            color: Colors.black54,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold)),
                                    SizedBox(height: 16),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.alarm_on_rounded,
                                          color: Colors.green,
                                        ),
                                        const SizedBox(width: 16),
                                        Text(
                                            '${model.meet!.begin} - ${model.meet!.end}',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.home_max_rounded,
                                          color: Colors.green,
                                        ),
                                        const SizedBox(width: 16),
                                        Text('Tempat ${model.meet!.place}',
                                            style: TextStyle(
                                                color: Colors.black54,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 8),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 26, vertical: 8),
                                      decoration: BoxDecoration(
                                          color: Colors.red,
                                          borderRadius:
                                              BorderRadius.circular(16)),
                                      child: Text(model.meet!.salary!,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                  ],
                                ),
                              );
                            }),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 50),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
