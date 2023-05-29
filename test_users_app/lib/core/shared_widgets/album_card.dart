import 'package:test_users_app/core/theme/app_colors.dart';
import 'package:test_users_app/core/theme/app_text_styles.dart';

import '../../modules/user_page/data/models/album_model.dart';
import 'package:flutter/material.dart';

class AlbumCard extends StatelessWidget {
  final AlbumModelWithPhotos album;

  const AlbumCard({
    required this.album,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size.width;
    final thumbSize = (mq - (16 * 2)) / 3;
    return Row(
      children: [
        Container(
          width: thumbSize,
          height: thumbSize,
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.cyan, width: 3),
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
              image: NetworkImage(
                album.photos.first.thumbnailUrl,
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 15,
        ),
        Expanded(
          child: Text(
            album.title,
            style: AppTextStyles.subtitle.copyWith(color: AppColors.cyan),
          ),
        ),
      ],
    );
  }
}
