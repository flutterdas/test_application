import '../../../../../core/app_data.dart';
import 'package:http/http.dart' as http;

class SendCommentRepo {
  Future<int> sendComment({
    required String name,
    required String email,
    required String body,
  }) async {
    const url = '${AppData.baseUrl}/comments/';
    final response = await http.post(
      Uri.parse(url),
      body: {
        'name': name,
        'email': email,
        'body': body,
      },
    );
    return response.statusCode;
  }
}
