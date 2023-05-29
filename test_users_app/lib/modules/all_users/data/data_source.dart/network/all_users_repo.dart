import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../../../core/app_data.dart';
import '../../model/user_model.dart';

class AllUsersRepo{
    Future<List<UserModel>> getAllUsers() async {
    const url = '${AppData.baseUrl}/users/';
    final response = await http.get(Uri.parse(url));
    final jsonResponse =
        List<Map<String, dynamic>>.from(json.decode(response.body) as List);
    return jsonResponse.map(UserModel.fromMap).toList();
  }
}