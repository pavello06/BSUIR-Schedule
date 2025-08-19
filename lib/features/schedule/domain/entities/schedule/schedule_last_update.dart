import 'package:equatable/equatable.dart';

class ScheduleLastUpdate extends Equatable {
  const ScheduleLastUpdate({required this.dateTime});

  final DateTime dateTime;

  @override
  List<Object?> get props => [dateTime];
}
