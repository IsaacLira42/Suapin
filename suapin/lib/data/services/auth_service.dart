import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/foundation.dart';

class AuthService {
  final _storage = const FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );

  final String _baseUrl = 'https://suap.ifrn.edu.br/api';

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
          await _storage.write(key: 'refresh_token', value: data['refresh']);

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

  Future<bool> restoreSession() async {
    final accessToken = await getToken();

    if (accessToken != null) {
      final verification = await _verifyToken(accessToken);

      if (verification == true) {
        return true;
      }

      if (verification == null) {
        return true;
      }
    }

    final refreshToken = await _storage.read(key: 'refresh_token');

    if (refreshToken != null) {
      final refreshed = await _refreshSession(refreshToken);

      if (refreshed == true) {
        return true;
      }

      if (refreshed == null) {
        return true;
      }
    }

    await _clearSession();
    return false;
  }

  Future<String?> getToken() async {
    return await _storage.read(key: 'auth_token');
  }

  Future<void> logout() async {
    await _clearSession();
  }

  Future<bool?> _verifyToken(String token) async {
    try {
      final response = await http
          .post(
            Uri.parse('$_baseUrl/token/verify'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({'token': token}),
          )
          .timeout(const Duration(seconds: 10));

      return response.statusCode == 200;
    } catch (e, stack) {
      debugPrint('Erro ao validar token: $e');
      debugPrint(stack.toString());
      return null;
    }
  }

  Future<bool?> _refreshSession(String refreshToken) async {
    try {
      final response = await http
          .post(
            Uri.parse('$_baseUrl/token/refresh'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({'refresh': refreshToken}),
          )
          .timeout(const Duration(seconds: 10));

      if (response.statusCode != 200) {
        return false;
      }

      final data = jsonDecode(response.body) as Map<String, dynamic>;
      final String? accessToken = data['access'] as String?;

      if (accessToken == null) {
        return false;
      }

      await _storage.write(key: 'auth_token', value: accessToken);

      final String? newRefreshToken = data['refresh'] as String?;
      if (newRefreshToken != null && newRefreshToken.isNotEmpty) {
        await _storage.write(key: 'refresh_token', value: newRefreshToken);
      }

      return true;
    } catch (e, stack) {
      debugPrint('Erro ao renovar sessão: $e');
      debugPrint(stack.toString());
      return null;
    }
  }

  Future<void> _clearSession() async {
    await _storage.delete(key: 'auth_token');
    await _storage.delete(key: 'refresh_token');
  }
}
