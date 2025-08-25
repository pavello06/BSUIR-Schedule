import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/usecases/usecase.dart';
import '../../../domain/usecases/schedule_usecases/get_active_schedule.dart';
import '../../../domain/usecases/schedule_usecases/get_current_week.dart';
import '../../../domain/usecases/schedule_usecases/get_lessons.dart';
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

    await currentWeekOrFailure.fold(
      (failure) {
        emit(ErrorState(hasData: false));
      },
      (currentWeek) async {
        emit(LoadingState(currentWeek: currentWeek, hasData: false));

        final scheduleOrFailure = await getActiveSchedule(NoParams());

        await scheduleOrFailure.fold(
          (failure) {
            emit(ErrorState.fromState(state: state as WithScheduleState));
          },
          (schedule) async {
            if (schedule == null) {
              emit(EmptyState(currentWeek: currentWeek));
              return;
            }

            // final lessonDaysOrFailure = await getLessons(
            //   GetLessonsParams(schedule: schedule, currentWeek: currentWeek),
            // );
            //
            // emit(
            //   lessonDaysOrFailure.fold(
            //     (failure) => ErrorState.fromState(state: state as WithScheduleState),
            //     (lessonDays) => LoadedState(
            //       currentWeek: currentWeek,
            //       schedule: schedule,
            //       lessonDays: lessonDays,
            //       examDays: [],
            //     ),
            //   ),
            // );
            emit(LoadedState(
              currentWeek: currentWeek,
              schedule: schedule,
              lessonDays: [],
              examDays: [],
            ),);
          },
        );
      },
    );
  }
}
