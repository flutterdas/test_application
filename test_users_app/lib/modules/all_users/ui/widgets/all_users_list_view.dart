import 'package:flutter/material.dart';
import 'package:test_users_app/modules/all_users/data/model/user_model.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../user_page/ui/screen/user_page.dart';

class AllUsersListView extends StatelessWidget {
  const AllUsersListView({super.key, required this.users});
  final List<UserModel> users;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      physics: const BouncingScrollPhysics(),
      itemCount: users.length,
      separatorBuilder: (_, __) => const SizedBox(
        height: 12,
      ),
      itemBuilder: (context, index) {
        final user = users[index];
        return GestureDetector(
          onTap: () {
            Navigator.push<void>(
              context,
              MaterialPageRoute(
                builder: (context) => UserPage(
                  userModel: user,
                ),
              ),
            );
          },
          child: Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: AppColors.white, borderRadius: BorderRadius.circular(20),
                boxShadow: [BoxShadow(spreadRadius: 1,blurRadius: 1,color: Colors.grey.shade300)]),
            child: ListTile(
              horizontalTitleGap: 8,
              title: Text(
                user.username,
                style: AppTextStyles.title.copyWith(color: AppColors.cyan),
              ),
              subtitle: Text(
                user.name,
                style: AppTextStyles.subtitle.copyWith(color: AppColors.cyan),
              ),
              leading: const Icon(
                Icons.person,
                size: 32,
                color: AppColors.cyan,
              ),
            ),
          ),
        );
      },
    );
  }
}
