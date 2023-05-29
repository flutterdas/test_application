import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_users_app/modules/post_page/data/data_source/network/send_comment_repo.dart';

class SendCommentBloc extends Bloc<SendCommentEvent, SendCommentState> {
  SendCommentBloc({required this.repo}) : super(SendCommentInitState()) {
    on<UserSendCommentEvent>((event, emit) async {
      try {
        emit(SendCommentLoadingState());
        final result = await repo.sendComment(
            name: event.name, email: event.email, body: event.body);
        emit(SendCommentSuccessState(statusCode: result));
      } catch (e) {
        SendCommentErrorState(errorText: e.toString());
      }
    });
    on<UserSendCommendInitEvent>((event, emit) {
      emit(SendCommentState());
    });
  }
  final SendCommentRepo repo;
}

//events
class SendCommentEvent {}

class UserSendCommentEvent extends SendCommentEvent {
  UserSendCommentEvent(
      {required this.body, required this.email, required this.name});
  final String name;
  final String email;
  final String body;
}

class UserSendCommendInitEvent extends SendCommentEvent {}

//states
class SendCommentState {}

class SendCommentInitState extends SendCommentState {}

class SendCommentLoadingState extends SendCommentState {}

class SendCommentSuccessState extends SendCommentState {
  SendCommentSuccessState({required this.statusCode});
  final int statusCode;
}

class SendCommentErrorState extends SendCommentState {
  SendCommentErrorState({required this.errorText});
  final String errorText;
}
