import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../core/extensions/build_context_extension.dart';
import '../../../../core/themes/app_colors.dart';
import '../../domain/entities/employee.dart';

class SearchEmployeeCardWidget extends StatelessWidget {
  const SearchEmployeeCardWidget({super.key, required this.employee});

  final Employee employee;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(4),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: IntrinsicHeight(
          child: Row(
            children: [
              ClipOval(
                child: CachedNetworkImage(
                  imageUrl: employee.photoLink,
                  errorWidget: (context, url, error) => Container(
                    color: context.theme.primaryColor,
                    width: 60,
                    height: 60,
                    child: const Icon(
                      Icons.person,
                      size: 35,
                      color: AppColors.foregroundColor,
                    ),
                  ),
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),
              ),

              const SizedBox(width: 10),

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${employee.lastName} ${employee.firstName} ${employee.middleName ?? ''}',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                      Text(
                        employee.academicDepartment!.join(', '),
                        style: TextStyle(fontSize: 13),
                      ),

                      if (employee.degreeAbbrev != '' && employee.rank != null)
                        Text(
                          '${employee.degreeAbbrev} ${employee.rank ?? ''}',
                          style: TextStyle(fontSize: 13),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
