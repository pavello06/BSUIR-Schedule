import 'package:bsuir_schedule/features/schedule/presentation/bloc/saved_schedules_bloc/saved_schedules_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/extensions/build_context_extension.dart';
import '../../../domain/entities/group/group.dart';
import '../../bloc/saved_schedules_bloc/saved_schedules_bloc.dart';
import '../card_widget.dart';

class SavedSchedulesGroupCardWidget extends StatelessWidget {
  const SavedSchedulesGroupCardWidget({super.key, required this.group});

  final Group group;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {context.read<SavedSchedulesBloc>().add(SetActiveScheduleEvent(query: group.name));},

      child: CardWidget(
        isNetworkPhoto: false,
        pathToPhoto: '',
        errorPhoto: Icons.people,

        title: group.name,
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${group.faculty.abbrev} ${group.speciality.abbrev} ${group.speciality.educationFormName} ${context.locale.courseNumber(group.course)}',
              style: TextStyle(fontSize: 13),
            ),

            Text(group.speciality.code, style: TextStyle(fontSize: 13)),
          ],
        ),

        onTaps: [],
        icons: [],
        texts: [],
      ),
    );
  }
}
