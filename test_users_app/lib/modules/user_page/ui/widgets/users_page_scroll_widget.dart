import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_users_app/core/theme/app_colors.dart';
import 'package:test_users_app/modules/all_users/data/model/user_model.dart';
import 'package:test_users_app/modules/user_page/data/models/album_model.dart';
import 'package:test_users_app/modules/user_page/data/models/post_model.dart';
import 'package:test_users_app/modules/user_page/ui/bloc/get_album_with_photo_bloc.dart';
import 'package:test_users_app/modules/user_page/ui/widgets/album_list_view.dart';
import 'package:test_users_app/modules/user_page/ui/widgets/post_list_view.dart';
import 'package:test_users_app/core/shared_widgets/loader.dart';
import 'package:test_users_app/modules/user_page/ui/widgets/user_page_item.dart';

import '../../../../core/services/services_locator.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../all_albums/ui/screen/all_albums_page.dart';
import '../../../all_posts/ui/screen/all_posts_page.dart';
import '../bloc/get_posts_bloc.dart';

class UserPageScrollWidget extends StatefulWidget {
  const UserPageScrollWidget({
    super.key,
    required this.userModel,
  });
  final UserModel userModel;

  @override
  State<UserPageScrollWidget> createState() => _UserPageScrollWidgetState();
}

class _UserPageScrollWidgetState extends State<UserPageScrollWidget> {
  final _postsBloc = sl<GetPostsBloc>();
  final _albumBloc = sl<GetAlbumWithPhotoBloc>();
  List<PostModel> posts = [];
  List<AlbumModelWithPhotos> albums = [];
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'User Data',
            style: AppTextStyles.title.copyWith(color: AppColors.cyan),
          ),
          const SizedBox(height: 16),
          UserPageItem(
            title: 'Name',
            value: widget.userModel.name,
          ),
          const SizedBox(height: 16),
          UserPageItem(
            title: 'Email',
            value: widget.userModel.email,
          ),
          const SizedBox(height: 16),
          UserPageItem(
            title: 'Phone',
            value: widget.userModel.phone,
          ),
          const SizedBox(height: 16),
          UserPageItem(
            title: 'Website',
            value: widget.userModel.website,
          ),
          const SizedBox(height: 16),
          Text(
            'Working company',
            style: AppTextStyles.title.copyWith(color: AppColors.cyan),
          ),
          const SizedBox(height: 16),
          UserPageItem(
            title: 'Name',
            value: widget.userModel.company.name,
          ),
          const SizedBox(height: 7),
          UserPageItem(
            title: 'BS',
            value: widget.userModel.company.bs,
          ),
          const SizedBox(height: 16),
          Text(
            'Address',
            style: AppTextStyles.title.copyWith(color: AppColors.cyan),
          ),
          const SizedBox(height: 16),
          UserPageItem(
            title: 'City',
            value: widget.userModel.address.city,
          ),
          const SizedBox(height: 7),
          UserPageItem(
            title: 'Street',
            value: widget.userModel.address.street,
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Users posts',
                style: AppTextStyles.title.copyWith(color: AppColors.cyan),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.push<void>(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AllPostsPage(
                          user: widget.userModel,
                          posts: posts,
                        ),
                      ),
                    );
                  },
                  child: Text(
                    'All posts',
                    style: AppTextStyles.bodyTextStyle
                        .copyWith(color: AppColors.gray.withOpacity(0.4)),
                  ))
            ],
          ),
          BlocProvider.value(
            value: _postsBloc,
            child: BlocBuilder<GetPostsBloc, GetPostsState>(
              builder: (context, state) {
                if (state is GetPostsLoadingState) {
                  return const Loader();
                }
                if (state is GetPostsSuccessState) {
                  posts = state.posts;
                  return PostsListView(
                    posts: state.posts,
                    userId: widget.userModel.id,
                  );
                }
                if (state is GetPostsErrorState) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [const Text('Error'), Text(state.errorText)],
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Text(
                  'Users albums',
                  style: AppTextStyles.title.copyWith(color: AppColors.cyan),
                ),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.push<void>(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AllAlbumsPage(
                          user: widget.userModel,
                          albums: albums,
                        ),
                      ),
                    );
                  },
                  child: Text(
                    'All albums',
                    style: AppTextStyles.bodyTextStyle
                        .copyWith(color: AppColors.gray.withOpacity(0.4)),
                  ))
            ],
          ),
          BlocProvider.value(
            value: _albumBloc,
            child: BlocBuilder<GetAlbumWithPhotoBloc, GetAlbumWithPhotoState>(
              builder: (context, state) {
                if (state is GetAlbumWithPhotoLoadingState) {
                  return const Loader();
                }
                if (state is GetAlbumWithPhotoSuccessState) {
                  albums = state.albums;
                  return AlbumListView(albums: state.albums);
                }
                return const SizedBox.shrink();
              },
            ),
          )
        ],
      ),
    );
  }
}
