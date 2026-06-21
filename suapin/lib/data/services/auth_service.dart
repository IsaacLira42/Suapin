import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/foundation.dart';

class AuthService {
  final _storage = const FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );

  final String _baseUrl = 'https://suap.ifrn.edu.br/api/';

  Future<bool> login(String matricula, String password) async {
    final url = Uri.parse('$_baseUrl/token/pair');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'username': matricula, 'password': password}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        final String? accessToken = data['access'];

        if (accessToken != null) {
          await _storage.write(key: 'auth_token', value: accessToken);

          return true;
        }
      }

      return false;
    } catch (e, stack) {
      debugPrint('Erro ao realizar login: $e');
      debugPrint(stack.toString());
      return false;
    }
  }

  Future<String?> getToken() async {
    return await _storage.read(key: 'auth_token');
  }

  Future<void> logout() async {
    await _storage.delete(key: 'auth_token');
  }
}
