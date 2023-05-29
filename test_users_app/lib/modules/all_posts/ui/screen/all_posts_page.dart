import 'package:flutter/material.dart';
import 'package:test_users_app/core/shared_widgets/app_appbar.dart';

import '../../../user_page/data/models/post_model.dart';
import '../../../all_users/data/model/user_model.dart';
import '../../../post_page/ui/screen/post_detail_page.dart';
import '../../../../core/shared_widgets/post_card.dart';
import '../../../../core/theme/app_colors.dart';

class AllPostsPage extends StatefulWidget {
  final UserModel user;
  final List<PostModel> posts;

  const AllPostsPage({
    required this.user,
    required this.posts,
    Key? key,
  }) : super(key: key);

  @override
  State<AllPostsPage> createState() => _AllPostsPageState();
}

class _AllPostsPageState extends State<AllPostsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppAppbar(title: widget.user.username),
      body: ListView.separated(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(16),
        itemCount: widget.posts.length,
        separatorBuilder: (_, __) => const SizedBox(
          height: 16,
        ),
        itemBuilder: (context, index) {
          final post = widget.posts[index];
          return GestureDetector(
            onTap: () {
              Navigator.push<void>(
                context,
                MaterialPageRoute(
                  builder: (context) => PostDetailPage(
                    userId: widget.user.id,
                    post: post,
                  ),
                ),
              );
            },
            child: PostCard(
              post: post,
            ),
          );
        },
      ),
    );
  }
}
