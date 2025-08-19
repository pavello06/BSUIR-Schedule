import 'package:equatable/equatable.dart';

import '../../../domain/entities/schedule/saved_schedule.dart';

abstract class SavedSchedulesState extends Equatable {
  const SavedSchedulesState();

  @override
  List<Object?> get props => [];
}

class InitialState extends SavedSchedulesState {
  const InitialState();
}

class LoadingState extends SavedSchedulesState {
  const LoadingState();
}

class LoadedState extends SavedSchedulesState {
  const LoadedState({required this.savedScheduleList});

  final List<SavedSchedule> savedScheduleList;

  @override
  List<Object?> get props => [...super.props, savedScheduleList];
}

class EmptyState extends SavedSchedulesState {
  const EmptyState();
}
