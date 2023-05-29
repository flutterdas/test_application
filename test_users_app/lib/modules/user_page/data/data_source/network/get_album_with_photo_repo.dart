import '../../../../../core/app_data.dart';
import '../../models/album_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class GetAlbumWithPhotoRepo {
   Future<List<AlbumModelWithPhotos>> getAlbumsByUserIdWithPhotos(
    int userId,
  ) async {
    final url = '${AppData.baseUrl}/user/$userId/albums?_embed=photos';
    final response = await http.get(Uri.parse(url));
    final jsonResponse =
        List<Map<String, dynamic>>.from(json.decode(response.body) as List);
    return jsonResponse.map(AlbumModelWithPhotos.fromMap).toList();
  }
}
