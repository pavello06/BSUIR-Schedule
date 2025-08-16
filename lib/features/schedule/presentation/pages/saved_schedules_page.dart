import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/extensions/build_context_extension.dart';
import '../../../../core/themes/app_colors.dart';
import '../bloc/saved_schedules_bloc/saved_schedules_bloc.dart';
import '../bloc/saved_schedules_bloc/saved_schedules_event.dart';
import '../bloc/saved_schedules_bloc/saved_schedules_state.dart';
import '../widgets/saved_schedules_widgets/saved_schedules_app_bar_widget.dart';
import '../widgets/search_employee_card_widget.dart';
import '../widgets/search_group_card_widget.dart';

class SavedSchedulesPage extends StatelessWidget {
  const SavedSchedulesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SavedSchedulesAppBarWidget(),
      body: BlocBuilder<SavedSchedulesBloc, SavedSchedulesState>(
        builder: (context, state) {
          return processState(context, state);
        },
      ),
    );
  }

  Widget processState(BuildContext context, SavedSchedulesState state) {
    if (state is InitialState) {
      context.read<SavedSchedulesBloc>().add(GetListEvent());

      return Container();
    } else if (state is LoadingState) {
      return Center(
        child: RefreshProgressIndicator(
          color: AppColors.foregroundColor,
          backgroundColor: context.theme.primaryColor,
        ),
      );
    } else if (state is LoadedState) {
      return ListView.builder(
        itemCount: state.savedScheduleList.length,
        itemBuilder: (BuildContext context, int index) {
          return state.savedScheduleList[index].isGroup
              ? SearchGroupCardWidget(
                  group: state.savedScheduleList[index].group!,
                )
              : SearchEmployeeCardWidget(
                  employee: state.savedScheduleList[index].employee!,
                );
        },
      );
    } else {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.sentiment_dissatisfied, size: 90),

            SizedBox(height: 20),

            SizedBox(
              width: mq.width * 0.7,
              child: Text(
                context.locale.savedSchedulesEmpty,
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      );
    }
  }
}
