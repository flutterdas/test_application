import 'package:flutter/material.dart';
import 'package:test_users_app/modules/post_page/data/model/comment_model.dart';

import '../../../../core/shared_widgets/comment_card.dart';

class CommentsListView extends StatelessWidget {
  const CommentsListView({super.key, required this.comments});
  final List<CommentModel> comments;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final comment = comments[index];
        return CommentCard(
          username: comment.name,
          comment: comment.body,
          email: comment.email,
        );
      },
      itemCount: comments.length,
    );
  }
}
