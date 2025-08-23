class CurrentWeekModel {
  CurrentWeekModel({required this.week, required this.dateTime});

  final int week;
  final int? dateTime;

  factory CurrentWeekModel.fromJson(Map<String, dynamic> json) {
    return CurrentWeekModel(week: json['week'], dateTime: json['dateTime']);
  }

  Map<String, dynamic> toJson() => {'week': week, 'dateTime': dateTime};
}
