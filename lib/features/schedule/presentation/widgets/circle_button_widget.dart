import 'package:flutter/material.dart';

import '../../../../core/themes/app_colors.dart';

class CircleButtonWidget extends StatelessWidget {
  const CircleButtonWidget({
    super.key,
    required this.onTap,
    required this.icon,
  });

  final Function onTap;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.primaryColor,
        ),
        width: 40,
        height: 40,
        child: Icon(icon),
      ),
    );
  }
}
