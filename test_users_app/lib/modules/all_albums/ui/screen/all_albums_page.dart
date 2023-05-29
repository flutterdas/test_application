import 'package:flutter/material.dart';
import 'package:test_users_app/core/shared_widgets/app_appbar.dart';

import '../../../user_page/data/models/album_model.dart';
import '../../../all_users/data/model/user_model.dart';
import '../../../album_page/ui/screen/album_detail_page.dart';
import '../../../../core/shared_widgets/album_card.dart';
import '../../../../core/theme/app_colors.dart';

class AllAlbumsPage extends StatelessWidget {
  final UserModel user;
  final List<AlbumModelWithPhotos> albums;

  const AllAlbumsPage({
    required this.user,
    required this.albums,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppAppbar(title: user.username),
      body: ListView.separated(
        padding: const EdgeInsets.all(15),
        separatorBuilder: (context, index) {
          return const SizedBox(
            height: 10,
          );
        },
        physics: const BouncingScrollPhysics(),
        itemCount: albums.length,
        itemBuilder: (context, index) {
          final album = albums[index];
          return GestureDetector(
            child: AlbumCard(
              album: album,
            ),
            onTap: () {
              Navigator.push<void>(
                context,
                MaterialPageRoute(
                  builder: (context) => AlbumDetailPage(
                    album: album,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
