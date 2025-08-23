import 'package:flutter/material.dart';

import '../../../../../core/extensions/build_context_extension.dart';
import '../../../../../core/themes/app_colors.dart';
import '../../../../../core/utils/date_util.dart';
import '../../../domain/entities/schedule/group_schedule.dart';
import 'schedule_info_widget.dart';

class ScheduleGroupInfoWidget extends StatelessWidget {
  const ScheduleGroupInfoWidget({super.key, required this.schedule});

  final GroupSchedule schedule;

  @override
  Widget build(BuildContext context) {
    final group = schedule.group;

    return ScheduleInfoWidget(
      isNetworkPhoto: false,
      pathToPhoto: '',
      errorPhoto: Icons.people,

      title: '${group.name} ${schedule.title ?? ''}',
      subtitle: Text(
        '${group.faculty.abbrev} ${group.speciality.abbrev}',
        style: TextStyle(fontSize: 15),
      ),

      onTaps: [() {}],
      icons: [Icon(Icons.eighteen_mp)],
      texts: [''],

      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _getTextInfo(context.locale.schedule_faculty(group.faculty.name)),

          _getTextInfo(context.locale.schedule_speciality(group.speciality.name)),

          _getTextInfo(context.locale.schedule_course(group.course)),

          _getTextInfo(context.locale.schedule_educationForm(group.speciality.educationFormName)),

          _getTextInfo(context.locale.schedule_specialityCode(group.speciality.code)),

          _getTextInfo(
            context.locale.schedule_termExist(
              DateUtil.getDay(schedule.lessonsEndDate, context.locale.localeName),
              DateUtil.getDay(schedule.lessonsStartDate, context.locale.localeName),
            ),
          ),

          _getTextInfo(
            context.locale.schedule_sessionExist(
              DateUtil.getDay(schedule.examsEndDate, context.locale.localeName),
              DateUtil.getDay(schedule.examsStartDate, context.locale.localeName),
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
