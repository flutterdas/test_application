import 'package:flutter/material.dart';
import 'package:test_users_app/core/theme/app_colors.dart';

class Loader extends StatelessWidget {
  const Loader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: AppColors.cyan,
      ),
    );
  }
}
