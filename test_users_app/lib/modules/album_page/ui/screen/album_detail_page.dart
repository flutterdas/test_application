import 'package:carousel_slider/carousel_slider.dart';
import 'package:test_users_app/core/shared_widgets/app_appbar.dart';
import 'package:test_users_app/core/theme/app_colors.dart';
import 'package:test_users_app/core/theme/app_text_styles.dart';

import '../../../user_page/data/models/album_model.dart';
import 'package:flutter/material.dart';

class AlbumDetailPage extends StatelessWidget {
  final AlbumModelWithPhotos album;
  const AlbumDetailPage({
    required this.album,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppAppbar(title: album.title),
      body: Center(
        child: CarouselSlider.builder(
          itemCount: album.photos.length,
          itemBuilder: (context, index, _) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Image(
                    image: NetworkImage(
                      album.photos[index].url,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    album.photos[index].title,
                    style: AppTextStyles.title.copyWith(color: AppColors.cyan),
                  )
                ],
              ),
            );
          },
          options: CarouselOptions(height: 400),
        ),
      ),
    );
  }
}
