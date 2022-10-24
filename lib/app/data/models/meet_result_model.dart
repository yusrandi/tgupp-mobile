class MeetResultModel {
  MeetResultModel({
    this.id,
    this.result,
    this.leader,
    this.notulen,
    this.userId,
    this.meetId,
  });

  int? id;
  String? result;
  String? leader;
  String? notulen;
  String? userId;
  String? meetId;

  factory MeetResultModel.fromJson(Map<String, dynamic> json) =>
      MeetResultModel(
        id: json["id"],
        result: json["result"],
        leader: json["leader"],
        notulen: json["notulen"],
        userId: json["user_id"].toString(),
        meetId: json["meet_id"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "result": result,
        "leader": leader,
        "notulen": notulen,
        "user_id": userId,
        "meet_id": meetId,
      };
}
