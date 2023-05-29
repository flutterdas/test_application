import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class UserPageItem extends StatelessWidget {
  const UserPageItem({super.key,required this.title,required this.value});
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return  Row(
            children: [
              Text(
                '$title:',
                style: AppTextStyles.bodyTextStyle.copyWith(color: AppColors.cyan),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                value,
                style: AppTextStyles.bodyTextStyle
                    .copyWith(color: AppColors.gray.withOpacity(0.5)),
              ),
            ],
          );
  }
}