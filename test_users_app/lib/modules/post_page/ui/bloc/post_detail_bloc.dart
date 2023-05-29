import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_users_app/modules/post_page/data/model/comment_model.dart';
import 'package:test_users_app/modules/post_page/data/data_source/network/post_detail_repo.dart';

class PostDetailBloc extends Bloc<PostDetailEvent, PostDetailState> {
  PostDetailBloc({required this.repo}) : super(PostDetailInitState()) {
    on<GetPostDetailCommentsEvent>((event, emit) async {
      try {
        emit(PostDetailLoadingState());
        final comments = await repo.getCommentsByPostId(event.userId);
        emit(PostDetailSuccessState(comments: comments));
      } catch (e) {
        emit(PostDetailErrorState(errorText: e.toString()));
      }
    });
  }
  final PostDetailRepo repo;
}

//event
class PostDetailEvent {}

class GetPostDetailCommentsEvent extends PostDetailEvent {
  GetPostDetailCommentsEvent({required this.userId});
  final int userId;
}

//states
class PostDetailState {}

class PostDetailInitState extends PostDetailState {}

class PostDetailLoadingState extends PostDetailState {}

class PostDetailSuccessState extends PostDetailState {
  PostDetailSuccessState({required this.comments});
  final List<CommentModel> comments;
}

class PostDetailErrorState extends PostDetailState {
  PostDetailErrorState({required this.errorText});
  final String errorText;
}
