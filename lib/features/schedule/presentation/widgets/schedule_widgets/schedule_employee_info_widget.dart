import 'package:flutter/material.dart';

import '../../../../../core/extensions/build_context_extension.dart';
import '../../../../../core/themes/app_colors.dart';
import '../../../../../core/utils/date_util.dart';
import '../../../domain/entities/schedule/employee_schedule.dart';
import 'schedule_info_widget.dart';

class ScheduleEmployeeInfoWidget extends StatelessWidget {
  const ScheduleEmployeeInfoWidget({super.key, required this.schedule});

  final EmployeeSchedule schedule;

  @override
  Widget build(BuildContext context) {
    final employee = schedule.employee;

    return ScheduleInfoWidget(
      isNetworkPhoto: true,
      pathToPhoto: '',
      errorPhoto: Icons.person,

      title: '${employee.lastName} ${employee.firstName} ${employee.middleName ?? ''}',
      subtitle: Text(schedule.title ?? '', style: TextStyle(fontSize: 15)),

      onTaps: [() {}],
      icons: [Icon(Icons.eighteen_mp)],
      texts: [''],

      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (employee.degreeAbbrev != null)
            _getTextInfo(context.locale.schedule_degree(employee.degreeAbbrev!)),

          if (employee.rank != null) _getTextInfo(context.locale.schedule_rank(employee.rank!)),

          if (employee.email != null) _getTextInfo(context.locale.schedule_email(employee.email!)),

          _getTextInfo(
            context.locale.schedule_termExist(
              DateUtil.getDay(schedule.lessonsEndDate, context.locale.localeName),
              DateUtil.getDay(schedule.lessonsStartDate, context.locale.localeName),
            ),
          ),

          if (schedule.exams != null)
            _getTextInfo(context.locale.schedule_examsExist)
          else
            _getTextInfo(context.locale.schedule_examsNotExist),
        ],
      ),
    );
  }

  Widget _getTextInfo(String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.label, color: AppColors.primaryColor, size: 20),

        const SizedBox(width: 5),

        Expanded(child: Text(text)),
      ],
    );
  }
}
