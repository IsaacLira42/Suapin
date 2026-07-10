import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// Exceção customizada para o erro 401
class UnauthorizedException implements Exception {}

class SuapApiService {
  final _storage = const FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );

  final String _baseUrl = 'https://suap.ifrn.edu.br/api';

  // Método auxiliar para injetar o Token no Cabeçalho
  Future<Map<String, String>> _getHeaders() async {
    final token = await _storage.read(key: 'auth_token');

    if (token == null) throw UnauthorizedException();

    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }

  // Busca os dados da Home em paralelo (Boletim, Avaliações e Turmas)
  Future<Map<String, dynamic>> fetchHomeData() async {
    try {
      final headers = await _getHeaders();

      // Executando os 3 endpoints simultaneamente para maior performance
      final responses = await Future.wait([
        http
            .get(
              Uri.parse('$_baseUrl/ensino/meu-boletim/2026/1/'),
              headers: headers,
            )
            .timeout(const Duration(seconds: 15)), // Exigência: Tratar Timeout
        http
            .get(
              Uri.parse('$_baseUrl/ensino/minhas-proximas-avaliacoes/'),
              headers: headers,
            )
            .timeout(const Duration(seconds: 15)),
        http
            .get(
              Uri.parse('$_baseUrl/ensino/minhas-turmas-virtuais/2026/1/'),
              headers: headers,
            )
            .timeout(const Duration(seconds: 15)),
      ]);

      // Exigência: Se o servidor retornar 401, exclui o token e derruba o usuário
      if (responses.any((r) => r.statusCode == 401)) {
        await _storage.delete(key: 'auth_token');
        throw UnauthorizedException();
      }

      // Exigência: Tratamento genérico de indisponibilidade
      if (responses.any((r) => r.statusCode != 200)) {
        throw HttpException('Falha na comunicação com o servidor SUAP.');
      }

      // Desserializa os JSONs e retorna os arrays ('results') extraídos
      return {
        'boletim': jsonDecode(utf8.decode(responses[0].bodyBytes))['results'],
        'avaliacoes': jsonDecode(
          utf8.decode(responses[1].bodyBytes),
        )['results'],
        'turmas': jsonDecode(utf8.decode(responses[2].bodyBytes))['results'],
      };
    } on TimeoutException {
      throw Exception('Tempo de conexão esgotado. Verifique sua internet.');
    } on SocketException {
      throw Exception('Servidor indisponível no momento.');
    } catch (e) {
      rethrow;
    }
  }
}
