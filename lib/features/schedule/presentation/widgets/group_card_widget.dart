import 'package:flutter/material.dart';

import '../../../../core/extensions/build_context_extension.dart';
import '../../domain/entities/group/group.dart';
import 'card_widget.dart';

class GroupCardWidget extends StatelessWidget {
  const GroupCardWidget({
    super.key,
    required this.group,
    required this.onTap,
    this.action,
  });

  final Group group;

  final GestureTapCallback? onTap;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return CardWidget(
      onTap: onTap,
      isNetworkPhoto: false,
      pathToPhoto: '',
      errorPhoto: Icons.people,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(group.name, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),

          Text(
            '${group.faculty.abbrev} ${group.speciality.abbrev} ${group.speciality.educationFormName} ${context.locale.courseNumber(group.course)}',
            style: TextStyle(fontSize: 13),
          ),

          Text(group.speciality.code, style: TextStyle(fontSize: 13)),
        ],
      ),
      action: action,
    );
  }
}
