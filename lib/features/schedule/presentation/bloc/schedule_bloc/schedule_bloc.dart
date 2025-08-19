import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/usecases/usecase.dart';
import '../../../domain/usecases/get_active_schedule.dart';
import '../../../domain/usecases/get_current_week.dart';
import '../../../domain/usecases/get_lessons.dart';
import 'schedule_event.dart';
import 'schedule_state.dart';

class ScheduleBloc extends Bloc<ScheduleEvent, ScheduleState> {
  ScheduleBloc({
    required this.getCurrentWeek,
    required this.getActiveSchedule,
    required this.getLessons,
  }) : super(InitialState()) {
    on<GetScheduleEvent>(_onGetScheduleEvent);
  }

  final GetCurrentWeek getCurrentWeek;
  final GetActiveSchedule getActiveSchedule;
  final GetLessons getLessons;

  void _onGetScheduleEvent(GetScheduleEvent event, Emitter<ScheduleState> emit) async {
    emit(
      LoadingState.fromState(state: state is WithScheduleState ? state as WithScheduleState : null),
    );

    final currentWeekOrFailure = await getCurrentWeek(NoParams());

    currentWeekOrFailure.fold(
      (failure) {
        emit(ErrorState());
      },
      (currentWeek) async {
        emit(LoadingState(currentWeek: currentWeek));

        final scheduleOrFailure = await getActiveSchedule(NoParams());

        scheduleOrFailure.fold(
          (failure) {
            emit(ErrorState());
          },
          (schedule) async {
            if (schedule == null) {
              emit(EmptyState(currentWeek: currentWeek));

              return;
            }

            final lessonDaysOrFailure = await getLessons(
              GetLessonsParams(schedule: schedule, currentWeek: currentWeek),
            );

            emit(
              lessonDaysOrFailure.fold(
                (failure) => ErrorState(),
                (lessonDays) => LoadedState(
                  currentWeek: currentWeek,
                  schedule: schedule,
                  lessonDays: lessonDays,
                  examDays: [],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
