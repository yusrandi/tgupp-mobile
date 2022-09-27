import 'package:emeeting_flutter/app/cores/core_colors.dart';
import 'package:emeeting_flutter/app/cores/core_images.dart';
import 'package:emeeting_flutter/app/cores/core_styles.dart';
import 'package:emeeting_flutter/app/data/models/meet_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';

import '../controllers/schedule_controller.dart';

class ScheduleView extends GetView<ScheduleController> {
  ScheduleView({Key? key}) : super(key: key);

  final ScheduleController scheduleController = Get.put(ScheduleController());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
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
                'Schedule Meeting',
                style: CoreStyles.uTitle,
              ),
            ],
          ),
          const SizedBox(height: 16),
          FutureBuilder<List<MeetModel>>(
            future: scheduleController.fetchListMeet(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              List<MeetModel> data = snapshot.data!;

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
                        MeetModel model = data[index];
                        return itemList(size, model);
                      }),
                ),
              );
            },
          ),
          const SizedBox(height: 50),
        ],
      ),
    );
  }

  Container itemList(Size size, MeetModel model) {
    return Container(
      width: size.width,
      child: Row(
        children: [
          Column(
            children: [
              Container(
                padding: EdgeInsets.all(5),
                child: Icon(FontAwesomeIcons.circle, color: CoreColor.primary),
              ),
              Container(
                width: 3,
                height: 150,
                color: Colors.grey,
              ),
            ],
          ),
          Expanded(
              child: Container(
            height: 170,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16), color: Colors.white),
            margin: EdgeInsets.only(left: 5),
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(model.name!,
                    style: TextStyle(
                        color: Colors.black54,
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),
                SizedBox(height: 16),
                Text('${model.begin} - ${model.end}',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold)),
                Text('Tempat ${model.place}',
                    style: TextStyle(
                        color: Colors.black54,
                        fontSize: 14,
                        fontWeight: FontWeight.bold)),
                Container(
                  margin: EdgeInsets.only(top: 8),
                  padding: EdgeInsets.symmetric(horizontal: 26, vertical: 8),
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(16)),
                  child: Text(model.barcode!,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }
}
