import 'dart:convert';

import 'package:plume/packages/apiService/api_client.dart';
import 'package:plume/packages/apiService/dto/dto.dart';



class ApiService {
  final ApiClient apiClient;
  ApiService({required this.apiClient});

  Future<List<User>> fetchUsers() async {
    final response = await apiClient.get('/users');
    final List<dynamic> jsonResponse = jsonDecode(response.body);
    return jsonResponse.map((i) => User.fromJson(i)).toList();
  }
}
