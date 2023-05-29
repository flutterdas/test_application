import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_users_app/modules/all_users/data/data_source.dart/network/all_users_repo.dart';
import 'package:test_users_app/modules/all_users/data/model/user_model.dart';

class AllUsersBloc extends Bloc<AllUsersEvent, AllUsersState> {
  AllUsersBloc({required this.repo}) : super(AllUsersInitState()) {
    on<GetAllUsersEvent>((event, emit) async {
      try {
        emit(AllUsersLoadingState());
        final users = await repo.getAllUsers();
        emit(AllUsersSuccessState(users: users));
      } catch (e) {
        emit(AllUsersErrorState(errorText: e.toString()));
      }
    });
  }
  final AllUsersRepo repo;
}

//events
class AllUsersEvent {}

class GetAllUsersEvent extends AllUsersEvent {}

//states
class AllUsersState {}

class AllUsersInitState extends AllUsersState {}

class AllUsersLoadingState extends AllUsersState {}

class AllUsersSuccessState extends AllUsersState {
  AllUsersSuccessState({required this.users});
  final List<UserModel> users;
}

class AllUsersErrorState extends AllUsersState {
  final String errorText;

  AllUsersErrorState({required this.errorText});
}
