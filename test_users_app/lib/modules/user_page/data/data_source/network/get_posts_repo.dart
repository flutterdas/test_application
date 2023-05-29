import '../../../../../core/app_data.dart';
import '../../models/post_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class GetPostsRepo {
  Future<List<PostModel>> getPostsByUserId(int userId) async {
    final url = '${AppData.baseUrl}/user/$userId/posts';
    final response = await http.get(Uri.parse(url));
    final jsonResponse =
        List<Map<String, dynamic>>.from(json.decode(response.body) as List);
    return jsonResponse.map(PostModel.fromMap).toList();
  }
}
