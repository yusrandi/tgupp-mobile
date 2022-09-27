import 'package:emeeting_flutter/app/data/services/meet_service.dart';

void main() async {
  var response = await MeetService().getAttendances('2');

  print(response.length);
}
