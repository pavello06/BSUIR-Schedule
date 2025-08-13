class ScheduleLastUpdateModel {
  ScheduleLastUpdateModel({required this.lastUpdateDate});

  final String lastUpdateDate;

  factory ScheduleLastUpdateModel.fromJson(Map<String, dynamic> json) {
    return ScheduleLastUpdateModel(
      lastUpdateDate: json['lastUpdateDate'],
    );
  }

  Map<String, dynamic> toJson() => {'lastUpdateDate': lastUpdateDate};
}
