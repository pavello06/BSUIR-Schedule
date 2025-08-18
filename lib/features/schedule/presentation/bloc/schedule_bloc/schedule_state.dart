import 'package:equatable/equatable.dart';

import '../../../domain/entities/current_week.dart';
import '../../../domain/entities/schedule.dart';
import '../../../domain/entities/study_day.dart';

abstract class ScheduleState extends Equatable {
  const ScheduleState();

  @override
  List<Object?> get props => [];
}

abstract class WithCurrentWeekState extends ScheduleState {
  const WithCurrentWeekState({required this.currentWeek});

  final CurrentWeek? currentWeek;

  @override
  List<Object?> get props => [...super.props, currentWeek];
}

abstract class WithScheduleState extends WithCurrentWeekState {
  const WithScheduleState({
    required super.currentWeek,
    required this.schedule,
    required this.lessonDayList,
    required this.examDayList,
  });

  final Schedule? schedule;
  final List<StudyDay>? lessonDayList;
  final List<StudyDay>? examDayList;

  @override
  List<Object?> get props => [...super.props, schedule, lessonDayList, examDayList];
}

class InitialState extends ScheduleState {}

class LoadingState extends WithScheduleState {
  const LoadingState({
    required super.currentWeek,
    required super.schedule,
    required super.lessonDayList,
    required super.examDayList,
  });
}

class LoadedState extends WithScheduleState {
  const LoadedState({
    required super.currentWeek,
    required super.schedule,
    required super.lessonDayList,
    required super.examDayList,
  });
}

class EmptyState extends WithCurrentWeekState {
  const EmptyState({required super.currentWeek});
}

class ErrorState extends ScheduleState {}
