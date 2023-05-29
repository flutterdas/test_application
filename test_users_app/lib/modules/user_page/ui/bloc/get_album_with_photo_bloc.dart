import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_users_app/modules/user_page/data/data_source/network/get_album_with_photo_repo.dart';
import 'package:test_users_app/modules/user_page/data/models/album_model.dart';

class GetAlbumWithPhotoBloc
    extends Bloc<GetAlbumWithPhotoEvent, GetAlbumWithPhotoState> {
  GetAlbumWithPhotoBloc({required this.repo})
      : super(GetAlbumWithPhotoInitState()) {
    on<GetAlbumWithPhotoDataEvent>((event, emit) async {
      try {
        emit(GetAlbumWithPhotoLoadingState());
        final albums = await repo.getAlbumsByUserIdWithPhotos(event.userId);
        emit(GetAlbumWithPhotoSuccessState(albums: albums));
      } catch (e) {
        emit(GetAlbumWithPhotoErrorState());
      }
    });
  }
  final GetAlbumWithPhotoRepo repo;
}

//events
class GetAlbumWithPhotoEvent {}

class GetAlbumWithPhotoDataEvent extends GetAlbumWithPhotoEvent {
  GetAlbumWithPhotoDataEvent({required this.userId});
  final int userId;
}

//state
class GetAlbumWithPhotoState {}

class GetAlbumWithPhotoInitState extends GetAlbumWithPhotoState {}

class GetAlbumWithPhotoLoadingState extends GetAlbumWithPhotoState {}

class GetAlbumWithPhotoSuccessState extends GetAlbumWithPhotoState {
  GetAlbumWithPhotoSuccessState({required this.albums});
  final List<AlbumModelWithPhotos> albums;
}

class GetAlbumWithPhotoErrorState extends GetAlbumWithPhotoState {}
