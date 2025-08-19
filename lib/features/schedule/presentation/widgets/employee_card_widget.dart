import 'package:flutter/material.dart';

import '../../domain/entities/employee/employee.dart';
import 'card_widget.dart';

class EmployeeCardWidget extends StatelessWidget {
  const EmployeeCardWidget({
    super.key,
    required this.employee,
    required this.onTap,
    this.action,
  });

  final Employee employee;

  final GestureTapCallback? onTap;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return CardWidget(
      onTap: onTap,
      isNetworkPhoto: true,
      pathToPhoto: employee.photoLink,
      errorPhoto: Icons.person,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${employee.lastName} ${employee.firstName} ${employee.middleName ?? ''}',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
          ),

          Text(employee.academicDepartment!.join(', '), style: TextStyle(fontSize: 13)),

          if (employee.degreeAbbrev != '' && employee.rank != null)
            Text('${employee.degreeAbbrev} ${employee.rank ?? ''}', style: TextStyle(fontSize: 13)),
        ],
      ),
      action: action,
    );
  }
}
