import 'package:http/http.dart' as http;
import 'package:plume/packages/apiService/api_client.dart';

class NativeClient implements ApiClient {
  @override
  Future get(String path) async {
    try {
      return await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users?_count=10'));
    } catch (e) {
      throw Error();
    }
  }

  @override
  Future post(String path) {
    return http.post(Uri.parse('https://jsonplaceholder.typicode.com/users?_count=10'));
  }
}
