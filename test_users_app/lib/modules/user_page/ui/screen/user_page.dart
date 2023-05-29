import 'package:test_users_app/core/shared_widgets/app_appbar.dart';
import 'package:test_users_app/core/theme/app_colors.dart';
import 'package:test_users_app/modules/user_page/ui/bloc/get_album_with_photo_bloc.dart';
import 'package:test_users_app/modules/user_page/ui/bloc/get_posts_bloc.dart';

import '../../../../core/services/services_locator.dart';
import '../../../all_users/data/model/user_model.dart';
import 'package:flutter/material.dart';

import '../widgets/users_page_scroll_widget.dart';

class UserPage extends StatefulWidget {
  final UserModel userModel;

  const UserPage({Key? key, required this.userModel}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  void initState() {
    sl<GetPostsBloc>().add(GetPostsDataEvent(userId: widget.userModel.id));
    sl<GetAlbumWithPhotoBloc>()
        .add(GetAlbumWithPhotoDataEvent(userId: widget.userModel.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppAppbar(title: widget.userModel.name),
        body: UserPageScrollWidget(
          userModel: widget.userModel,
        ));
  }
}
