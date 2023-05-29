import '../../../../../core/app_data.dart';
import '../../model/comment_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class PostDetailRepo {
  Future<List<CommentModel>> getCommentsByPostId(int postId) async {
    final url = '${AppData.baseUrl}/posts/$postId/comments/';
    final response = await http.get(Uri.parse(url));
    final jsonResponse =
        List<Map<String, dynamic>>.from(json.decode(response.body) as List);
    return jsonResponse.map(CommentModel.fromMap).toList();
  }
}
