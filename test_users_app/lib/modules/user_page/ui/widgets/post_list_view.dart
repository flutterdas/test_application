import 'package:flutter/material.dart';
import 'package:test_users_app/modules/user_page/data/models/post_model.dart';

import '../../../post_page/ui/screen/post_detail_page.dart';
import '../../../../core/shared_widgets/post_card.dart';

class PostsListView extends StatelessWidget {
  const PostsListView({super.key, required this.posts,required this.userId});
  final List<PostModel> posts;
  final int userId;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: 3,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      separatorBuilder: (_, __) => const SizedBox(
        height: 16,
      ),
      itemBuilder: (context, index) {
        final post = posts[index];
        return GestureDetector(
          onTap: () {
            Navigator.push<void>(
              context,
              MaterialPageRoute(
                builder: (context) => PostDetailPage(
                  post: post,
                  userId: userId,
                ),
              ),
            );
          },
          child: PostCard(
            post: post,
          ),
        );
      },
    );
  }
}
