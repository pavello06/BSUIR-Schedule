import 'package:equatable/equatable.dart';

import '../../../domain/entities/current_week.dart';
import '../../../domain/entities/schedule/schedule.dart';
import '../../../domain/entities/study_day.dart';

abstract class ScheduleState extends Equatable {
  const ScheduleState();

  @override
  List<Object?> get props => [];
}

abstract class WithCurrentWeekState extends ScheduleState {
  const WithCurrentWeekState({this.currentWeek});

  final CurrentWeek? currentWeek;

  @override
  List<Object?> get props => [...super.props, currentWeek];
}

abstract class WithScheduleState extends WithCurrentWeekState {
  const WithScheduleState({
    super.currentWeek,
    this.schedule,
    this.lessonDays,
    this.examDays,
  });

  final Schedule? schedule;
  final List<StudyDay>? lessonDays;
  final List<StudyDay>? examDays;

  @override
  List<Object?> get props => [...super.props, schedule, lessonDays, examDays];
}

class InitialState extends ScheduleState {}

class LoadingState extends WithScheduleState {
  const LoadingState({
    super.currentWeek,
    super.schedule,
    super.lessonDays,
    super.examDays,
  });

  LoadingState.fromState({WithScheduleState? state})
    : super(
        currentWeek: state?.currentWeek,
        schedule: state?.schedule,
        lessonDays: state?.lessonDays,
        examDays: state?.examDays,
      );
}

class LoadedState extends WithScheduleState {
  const LoadedState({
    required super.currentWeek,
    required super.schedule,
    required super.lessonDays,
    required super.examDays,
  });

  LoadedState.fromState({required WithScheduleState state})
    : super(
        currentWeek: state.currentWeek,
        schedule: state.schedule,
        lessonDays: state.lessonDays,
        examDays: state.examDays,
      );
}

class EmptyState extends WithCurrentWeekState {
  const EmptyState({required super.currentWeek});
}

class ErrorState extends ScheduleState {}
