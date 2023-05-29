import 'package:flutter/material.dart';
import 'package:test_users_app/core/theme/app_text_styles.dart';

import '../theme/app_colors.dart';

class AppAppbar extends StatelessWidget implements PreferredSizeWidget {
  const AppAppbar({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
          title: Text(title),
          centerTitle: true,
          titleTextStyle: AppTextStyles.title,
          backgroundColor: AppColors.cyan,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(20),
            ),
          )
    );
  }
  @override
   Size get preferredSize => const Size.fromHeight(50);
}
