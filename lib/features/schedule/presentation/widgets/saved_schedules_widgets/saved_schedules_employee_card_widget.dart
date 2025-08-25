import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/employee/employee.dart';
import '../../bloc/saved_schedules_bloc/saved_schedules_bloc.dart';
import '../../bloc/saved_schedules_bloc/saved_schedules_event.dart';
import '../card_widget.dart';

class SavedSchedulesEmployeeCardWidget extends StatelessWidget {
  const SavedSchedulesEmployeeCardWidget({super.key, required this.employee});

  final Employee employee;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.read<SavedSchedulesBloc>().add(
          SetActiveScheduleEvent(
            query: '${employee.lastName} ${employee.firstName} ${employee.middleName ?? ''}',
          ),
        );
      },
      child: CardWidget(
        isNetworkPhoto: true,
        pathToPhoto: employee.photoLink,
        errorPhoto: Icons.person,

        title: '${employee.lastName} ${employee.firstName} ${employee.middleName ?? ''}',
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(employee.academicDepartment!.join(', '), style: TextStyle(fontSize: 13)),

            if (employee.degreeAbbrev != '' && employee.rank != null)
              Text(
                '${employee.degreeAbbrev} ${employee.rank ?? ''}',
                style: TextStyle(fontSize: 13),
              ),
          ],
        ),

        onTaps: [],
        icons: [],
        texts: [],
      ),
    );
  }
}
