import '../../modules/user_page/data/models/post_model.dart';
import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class PostCard extends StatelessWidget {
  final PostModel post;

  const PostCard({
    required this.post,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(color: AppColors.cyan,
      borderRadius: BorderRadius.circular(20)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              post.title,
              style: AppTextStyles.title,
              textAlign: TextAlign.start,
            ),
          ),
          const SizedBox(height: 7),
          Text(
            post.body,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.bodyTextStyle.copyWith(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
