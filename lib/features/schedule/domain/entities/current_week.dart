import 'package:equatable/equatable.dart';

class CurrentWeek extends Equatable {
  const CurrentWeek({required this.week, required this.dateTime});

  final int week;
  final DateTime dateTime;

  @override
  List<Object?> get props => [week, dateTime];
}
