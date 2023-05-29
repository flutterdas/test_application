import 'package:flutter/material.dart';
import 'package:test_users_app/core/theme/app_colors.dart';
import 'package:test_users_app/core/theme/app_text_styles.dart';

class CommentCard extends StatelessWidget {
  final String email;
  final String username;
  final String comment;

  const CommentCard({
    required this.email,
    required this.username,
    required this.comment,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        border: Border.all(
          color: AppColors.cyan,
          width: 3,
        ),
      ),
      child: Column(
        children: [
          ListTile(
            style: ListTileStyle.list,
            title: Text(
              username,
              style:
                  AppTextStyles.subtitle.copyWith(color: AppColors.cyan),
            ),
            subtitle: Text(email),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(comment),
          )
        ],
      ),
    );
  }
}
