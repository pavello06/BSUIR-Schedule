import 'dart:io';

import 'package:flutter/material.dart';

import '../../../../core/extensions/build_context_extension.dart';
import '../../../../core/themes/app_colors.dart';
import '../../domain/entities/group.dart';

class SearchGroupCardWidget extends StatelessWidget {
  const SearchGroupCardWidget({super.key, required this.group});

  final Group group;

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
                child: Image.file(
                  File(''),
                  errorBuilder: (context, url, error) => Container(
                    color: context.theme.primaryColor,
                    width: 60,
                    height: 60,
                    child: const Icon(
                      Icons.people,
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
                        group.name,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                      Text(
                        '${group.faculty.abbrev} ${group.speciality.abbrev} ${group.speciality.educationFormName} ${context.locale.courseNumber(group.course)}',
                        style: TextStyle(fontSize: 13),
                      ),

                      Text(
                        group.speciality.code,
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
