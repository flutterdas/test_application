import 'package:get_it/get_it.dart';
import 'package:test_users_app/modules/all_users/data/data_source.dart/network/all_users_repo.dart';
import 'package:test_users_app/modules/all_users/ui/bloc/all_users_bloc.dart';
import 'package:test_users_app/modules/post_page/data/data_source/network/post_detail_repo.dart';
import 'package:test_users_app/modules/post_page/data/data_source/network/send_comment_repo.dart';
import 'package:test_users_app/modules/post_page/ui/bloc/post_detail_bloc.dart';
import 'package:test_users_app/modules/post_page/ui/bloc/send_comment_bloc.dart';
import 'package:test_users_app/modules/user_page/data/data_source/network/get_album_with_photo_repo.dart';
import 'package:test_users_app/modules/user_page/data/data_source/network/get_posts_repo.dart';
import 'package:test_users_app/modules/user_page/ui/bloc/get_album_with_photo_bloc.dart';
import 'package:test_users_app/modules/user_page/ui/bloc/get_posts_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerLazySingleton<AllUsersRepo>(() => AllUsersRepo());
  sl.registerLazySingleton<AllUsersBloc>(() => AllUsersBloc(repo: sl()));
  sl.registerLazySingleton<GetPostsRepo>(() => GetPostsRepo());
  sl.registerLazySingleton<GetPostsBloc>(() => GetPostsBloc(repo: sl()));
  sl.registerFactory<GetAlbumWithPhotoRepo>(() => GetAlbumWithPhotoRepo());
  sl.registerLazySingleton<GetAlbumWithPhotoBloc>(
      () => GetAlbumWithPhotoBloc(repo: sl()));
  sl.registerLazySingleton<PostDetailRepo>(() => PostDetailRepo());
  sl.registerLazySingleton<PostDetailBloc>(() => PostDetailBloc(repo: sl()));
  sl.registerLazySingleton<SendCommentRepo>(() => SendCommentRepo());
  sl.registerLazySingleton<SendCommentBloc>(() => SendCommentBloc(repo: sl()));
}
