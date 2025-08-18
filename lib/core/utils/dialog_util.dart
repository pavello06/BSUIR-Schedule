import 'package:flutter/material.dart';

import '../extensions/build_context_extension.dart';
import '../themes/app_colors.dart';

class DialogUtil {
  static void showSnackBar(BuildContext context, Icon icon, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        content: Row(
          children: [
            icon,

            SizedBox(width: 5,),
            
            Text(msg, style: TextStyle(color: AppColors.foregroundColor),)
          ],
        ),
        backgroundColor: context.theme.primaryColor,
        behavior: SnackBarBehavior.floating,
        duration: Duration(milliseconds: 500),
      ),
    );
  }
}
