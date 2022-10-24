import 'package:emeeting_flutter/app/data/models/meet_result_model.dart';
import 'package:emeeting_flutter/app/modules/schedule/views/schedule_view.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';

import '../../../cores/core_colors.dart';
import '../../../cores/core_images.dart';
import '../../../cores/core_styles.dart';
import '../../../data/models/meet_model.dart';
import '../controllers/history_controller.dart';

class HistoryView extends GetView<HistoryController> {
  HistoryView({Key? key}) : super(key: key);

  final HistoryController historyController = Get.put(HistoryController());
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
                  'Histories Meeting',
                  style: CoreStyles.uTitle,
                ),
              ],
            ),
            const SizedBox(height: 16),
            FutureBuilder<List<MeetModel>>(
              future: historyController.fetchListMeet(),
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
                          MeetResultModel meetResultModel =
                              model.meetResults![0];
                          return Card(
                              child: ExpansionTile(
                            childrenPadding: EdgeInsets.all(16),
                            title: itemList(size, model),
                            children: [
                              Row(
                                children: [
                                  Container(
                                      width: 100,
                                      child: const Text("Pimpinan Rapat ")),
                                  Text(": ${meetResultModel.leader!}"),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Container(
                                      width: 100,
                                      child: const Text("Notulen Rapat ")),
                                  Text(": ${meetResultModel.notulen!}"),
                                ],
                              ),
                              Divider(),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Container(
                                      width: 100,
                                      child: const Text("Hasil Rapat ")),
                                  Expanded(
                                      child:
                                          Text(": ${meetResultModel.result!}")),
                                ],
                              ),
                            ],
                          ));
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

  Container itemList(Size size, MeetModel model) {
    return Container(
      padding: EdgeInsets.only(bottom: 16),
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
          Text('Peserta Hadir ${model.meetAttendances!.length} Orang',
              style: TextStyle(
                  color: Colors.black54,
                  fontSize: 14,
                  fontWeight: FontWeight.bold)),
          Container(
            margin: EdgeInsets.only(top: 8),
            padding: EdgeInsets.symmetric(horizontal: 26, vertical: 8),
            decoration: BoxDecoration(
                color: Colors.green, borderRadius: BorderRadius.circular(16)),
            child: Text('anda hadir',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}
