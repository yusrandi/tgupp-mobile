class Api {
  //* Creating instance constructor;
  static Api instance = Api();
  //* Base API URL

  // static const domain = "http://192.168.8.157/tgupp-api/public";

  static const domain = "https://tgupp.my.id";

  static const baseURL = "$domain/api";
  static const imageURL = "$domain/storage/photos/";

  String scheduleUrl = "$baseURL/schedule";
  String historyUrl = "$baseURL/history";
  String attendanceUrl = "$baseURL/attendance";
  String meetUrl = "$baseURL/meet";
  String loginUrl = "$baseURL/login";
  String profileUrl = "$baseURL/profile";
}
