import 'package:emeeting_flutter/app/cores/core_colors.dart';
import 'package:emeeting_flutter/app/cores/core_styles.dart';
import 'package:emeeting_flutter/app/data/models/meet_model.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:slide_to_act/slide_to_act.dart';

import '../../../routes/app_pages.dart';
import '../controllers/meetdetail_controller.dart';

class MeetdetailView extends GetView<MeetdetailController> {
  final MeetdetailController _meetdetailController =
      Get.put(MeetdetailController());

  @override
  Widget build(BuildContext context) {
    String code = Get.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Rapat $code'),
        centerTitle: false,
        backgroundColor: CoreColor.primary,
      ),
      body: FutureBuilder<MeetModel>(
        future: _meetdetailController.getMeet(code),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          MeetModel data = snapshot.data!;
          if (data != null) {
            return Container(
              padding: const EdgeInsets.all(16),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      child: Builder(
                        builder: (context) {
                          final GlobalKey<SlideActionState> _key = GlobalKey();
                          return SlideAction(
                            key: _key,
                            onSubmit: () {
                              // Get.offAndToNamed(Routes.AUTH);
                              // Future.delayed(Duration(seconds: 1),
                              //     () => Get.offAndToNamed(Routes.AUTH));

                              _meetdetailController.storeAttendance(
                                  '2', data.id.toString());
                            },
                            alignment: Alignment.centerRight,
                            sliderButtonIcon: const Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: Colors.red),
                            innerColor: Colors.white,
                            outerColor: Colors.red,
                            borderRadius: 16,
                            child: const Text(
                              ' Geser Kekanan untuk hadir',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Center(
                      child: Obx(() => _meetdetailController.status.value ==
                              Status.running
                          ? CircularProgressIndicator(color: CoreColor.primary)
                          : Container())),
                  Column(
                    children: [
                      Text(data.name!, style: CoreStyles.uTitle),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          const Icon(Icons.alarm_on_rounded),
                          const SizedBox(width: 16),
                          Text('${data.begin!} - ${data.end!}',
                              style: CoreStyles.uSubTitle),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(Icons.home_max_rounded),
                          const SizedBox(width: 16),
                          Text(data.place!, style: CoreStyles.uSubTitle),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(Icons.attach_money_rounded),
                          const SizedBox(width: 16),
                          Text(data.salary!, style: CoreStyles.uSubTitle),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            );
          } else {
            return Container(child: Text('Data Tidak Tersedia'));
          }
        },
      ),
    );
  }
}
