import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_users_app/modules/user_page/data/data_source/network/get_posts_repo.dart';

import '../../data/models/post_model.dart';

class GetPostsBloc extends Bloc<GetPostsEvent, GetPostsState> {
  GetPostsBloc({required this.repo}) : super(GetPostsInitState()) {
    on<GetPostsDataEvent>((event, emit) async {
      try {
        emit(GetPostsLoadingState());
        final posts = await repo.getPostsByUserId(event.userId);
        emit(GetPostsSuccessState(posts: posts));
      } catch (e) {
        emit(GetPostsErrorState(errorText: e.toString()));
      }
    });
  }
  final GetPostsRepo repo;
}

//events
class GetPostsEvent {}

class GetPostsDataEvent extends GetPostsEvent {
  GetPostsDataEvent({required this.userId});
  final int userId;
}

//states
class GetPostsState {}

class GetPostsInitState extends GetPostsState {}

class GetPostsLoadingState extends GetPostsState {}

class GetPostsSuccessState extends GetPostsState {
  GetPostsSuccessState({required this.posts});
  final List<PostModel> posts;
}

class GetPostsErrorState extends GetPostsState {
  GetPostsErrorState({required this.errorText});
  final String errorText;
}
