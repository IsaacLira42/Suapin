import 'package:flutter/material.dart';

import '../../data/mappers/suap_discipline_mapper.dart';
import '../../data/services/suap_api_service.dart';
import '../widgets/base_page.dart';
import '../widgets/discipline_card.dart';
import '../widgets/titulo_da_pagina.dart';

class DisciplinasPage extends StatefulWidget {
  const DisciplinasPage({super.key});

  @override
  State<DisciplinasPage> createState() => _DisciplinasPageState();
}

class _DisciplinasPageState extends State<DisciplinasPage> {
  final SuapApiService _apiService = SuapApiService();
  late Future<Map<String, dynamic>> _homeDataFuture;

  @override
  void initState() {
    super.initState();
    _homeDataFuture = _apiService.fetchHomeData();
  }

  void _reloadData() {
    setState(() {
      _homeDataFuture = _apiService.fetchHomeData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      currentIndex: 1,
      child: FutureBuilder<Map<String, dynamic>>(
        future: _homeDataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SizedBox(
              height: 280,
              child: Center(
                child: CircularProgressIndicator(color: Color(0xFF006D42)),
              ),
            );
          }

          if (snapshot.hasError) {
            final isUnauthorized = snapshot.error is UnauthorizedException;

            // Futuramente, este ponto pode acionar o redirecionamento para Login.
            final message = isUnauthorized
                ? 'Sua sessão expirou. Faça login novamente para continuar.'
                : 'Não foi possível carregar suas disciplinas agora.';

            return SizedBox(
              height: 280,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 64,
                      color: Colors.red,
                    ),
                    const SizedBox(height: 16),
                    Text(message, textAlign: TextAlign.center),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _reloadData,
                      child: const Text('Tentar novamente'),
                    ),
                  ],
                ),
              ),
            );
          }

          if (!snapshot.hasData) {
            return const SizedBox.shrink();
          }

          final homeData = snapshot.data!;
          final boletim = (homeData['boletim'] as List<dynamic>? ?? const []);
          final avaliacoes =
              (homeData['avaliacoes'] as List<dynamic>? ?? const []);
          final disciplinas = mapBoletimListToDisciplines(boletim, avaliacoes);
          final mediaGeral = calculateAverageGrade(disciplinas);
          final statusSemestre = classifySemesterStatus(mediaGeral);
          final semestreLabel = _buildSemesterLabel(homeData);

          if (disciplinas.isEmpty) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TituloDaPagina(
                  titulo: 'Lista de Disciplinas',
                  textoAuxiliar: semestreLabel,
                  usuario: '',
                ),
                const SizedBox(height: 12),
                _buildOverview(mediaGeral, statusSemestre),
                const SizedBox(height: 20),
                _buildEmptyState(),
              ],
            );
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TituloDaPagina(
                titulo: 'Lista de Disciplinas',
                textoAuxiliar: semestreLabel,
                usuario: '',
              ),
              const SizedBox(height: 12),
              _buildOverview(mediaGeral, statusSemestre),
              const SizedBox(height: 20),
              ...disciplinas.map(
                (discipline) => DisciplineCard(data: discipline),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildOverview(double? mediaGeral, String statusSemestre) {
    final mediaExibida = mediaGeral?.toStringAsFixed(1) ?? 'N/A';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 8),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Média Geral',
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    mediaExibida,
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF065F46),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 8),
              const Expanded(child: SizedBox()),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFF10B981),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 8),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Status do Semestre\n$statusSemestre',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Icon(Icons.verified, color: Colors.white),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyState() {
    return SizedBox(
      height: 220,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.menu_book_outlined, size: 56, color: Colors.grey),
            SizedBox(height: 12),
            Text('Nenhuma disciplina encontrada.', textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }

  String _buildSemesterLabel(Map<String, dynamic> homeData) {
    final candidates = [
      ...?((homeData['boletim'] as List<dynamic>?)?.whereType<Map>().map(
        (item) => Map<String, dynamic>.from(item),
      )),
      ...?((homeData['turmas'] as List<dynamic>?)?.whereType<Map>().map(
        (item) => Map<String, dynamic>.from(item),
      )),
    ];

    for (final item in candidates) {
      final anoLetivo = item['ano_letivo']?.toString();
      final periodoLetivo = item['periodo_letivo']?.toString();

      if (anoLetivo != null &&
          anoLetivo.isNotEmpty &&
          periodoLetivo != null &&
          periodoLetivo.isNotEmpty) {
        return 'SEMESTRE ATUAL: $anoLetivo.$periodoLetivo';
      }
    }

    return 'SEMESTRE ATUAL';
  }
}
