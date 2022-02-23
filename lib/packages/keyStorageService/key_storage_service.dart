import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class KeyStorageService {
  final _storage = const FlutterSecureStorage();

  Future<String?> getItem(String key, ) async {
    return await _storage.read(key: key);
  }

  Future<void> setItem(String key, String value) async {
    return await _storage.write(
        key: key,
        value: value,
    );
  }

  Future<bool> containsItem(String key) async {
    return await _storage.containsKey(key: key);
  }

  Future<void> deleteItem(String key) async {
    return await _storage.delete(key: key);
  }
}
