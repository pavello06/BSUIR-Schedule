import 'package:flutter/material.dart';

import '../../../../../core/extensions/build_context_extension.dart';
import '../../../../../core/themes/app_colors.dart';
import '../../../domain/entities/subject/subject.dart';

class ScheduleSubjectWidget extends StatelessWidget {
  const ScheduleSubjectWidget({super.key, required this.isGroup, required this.subject});

  final bool isGroup;
  final Subject subject;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: InkWell(
        child: IntrinsicHeight(
          child: Row(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(subject.startLessonTime, style: TextStyle(fontSize: 17)),
                  Text(subject.endLessonTime),
                ],
              ),

              const SizedBox(width: 5),

              VerticalDivider(
                thickness: 3,
                color:
                    subject.lessonTypeAbbrev == 'ЛК' || subject.lessonTypeAbbrev == 'Консультация'
                    ? AppColors.lecture
                    : subject.lessonTypeAbbrev == 'ПЗ'
                    ? AppColors.practical
                    : AppColors.laboratory,
              ),

              const SizedBox(width: 5),

              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          subject.subject,
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),

                        if (subject.auditories != null)
                          Text(
                            '${subject.auditories![0]}${subject.auditories!.length > 1 ? ', +${(subject.auditories!.length - 1)}' : ''}',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                      ],
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          isGroup
                              ? '${subject.employees![0].lastName} ${subject.employees![0].firstName[0]}.${subject.employees![0].middleName == null ? '' : '${subject.employees![0].middleName![0]}.'}${subject.employees!.length > 1 ? ', +${subject.employees!.length - 1}' : ''}'
                              : '${subject.groups[0]}${subject.groups.length > 1 ? ', +${subject.groups.length - 1}' : ''}',
                        ),

                        if (subject.numSubgroup != 0)
                          Text(context.locale.schedules_numSubGroup(subject.numSubgroup))
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
