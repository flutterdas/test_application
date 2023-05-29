import 'package:flutter/material.dart';
import 'package:test_users_app/modules/user_page/data/models/album_model.dart';

import '../../../album_page/ui/screen/album_detail_page.dart';
import '../../../../core/shared_widgets/album_card.dart';

class AlbumListView extends StatelessWidget {
  const AlbumListView({super.key,required this.albums});
  final List<AlbumModelWithPhotos> albums;

  @override
  Widget build(BuildContext context) {
    return  ListView.separated(
            itemCount: 3,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            separatorBuilder: (_, __) => const SizedBox(
              height: 16,
            ),
            itemBuilder: (context, index) {
              final album = albums[index];
              return GestureDetector(
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
                child: AlbumCard(
                  album: album,
                ),
              );
            },
          );
  }
}