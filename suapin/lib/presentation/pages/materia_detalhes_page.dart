import 'package:flutter/material.dart';

import '../../domain/entities/discipline_data.dart';

class MateriaDetalhesPage extends StatelessWidget {
  final DisciplineData? data;

  const MateriaDetalhesPage({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    final DisciplineData? resolvedData =
        data ?? ModalRoute.of(context)?.settings.arguments as DisciplineData?;
    final DisciplineData displayData =
        resolvedData ??
        DisciplineData(
          title: 'Disciplina',
          nomeCompleto: 'Disciplina',
          teacher: 'Professor não informado',
          percentual: 0.0,
          percentualFrequencia: null,
          nota: 'N/A',
          notaNumerica: null,
          faltas: '00',
          faltasNumericas: null,
          tipo: 'Não informado',
          icon: Icons.book,
          codigoDiario: '',
          rawBoletim: const {},
          avaliacoes: const [],
        );

    return Scaffold(
      backgroundColor: const Color(0xFFF7F9F9),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black87),
        title: Text(
          displayData.title,
          style: const TextStyle(color: Colors.black87),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTabs(),
              const SizedBox(height: 16),
              _mediaCard(displayData),
              const SizedBox(height: 12),
              _presencaCard(displayData),
              const SizedBox(height: 12),
              _avaliacoesCard(displayData),
              const SizedBox(height: 12),
              _analiseRiscoCard(displayData),
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: () {
                    // Mantido apenas como ação demonstrativa da tela.
                    debugPrint(
                      'MateriaDetalhesPage: popping with result favorited',
                    );
                    Navigator.of(context).pop({'favorited': true});
                  },
                  child: const Text('Marcar como Favorita (retorna resultado)'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabs() {
    return DefaultTabController(
      length: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TabBar(
            labelColor: const Color(0xFF065F46),
            unselectedLabelColor: Colors.grey,
            indicatorColor: const Color(0xFF065F46),
            tabs: const [
              Tab(text: 'Desempenho'),
              Tab(text: 'Avaliações'),
              Tab(text: 'Aulas'),
            ],
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _mediaCard(DisciplineData data) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 8),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'MÉDIA ATUAL',
            style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                data.nota,
                style: const TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF065F46),
                ),
              ),
              const SizedBox(width: 8),
              const Text('/ 10.0', style: TextStyle(color: Colors.grey)),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Professor: ${data.teacher}',
            style: const TextStyle(color: Color(0xFF4B5563)),
          ),
          const SizedBox(height: 4),
          Text(
            'Tipo: ${data.tipo}',
            style: const TextStyle(color: Color(0xFF4B5563)),
          ),
          const SizedBox(height: 8),
          Row(
            children: const [
              Icon(Icons.trending_up, color: Color(0xFF10B981), size: 16),
              SizedBox(width: 6),
              Text(
                '+12% vs. média da turma',
                style: TextStyle(color: Color(0xFF10B981)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _presencaCard(DisciplineData data) {
    final percent = data.percentual.clamp(0, 1).toDouble();
    final percentualExibido =
        data.percentualFrequencia?.toStringAsFixed(0) ?? '0';

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 8),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'PRESENÇA',
            style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            '$percentualExibido%',
            style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'Faltas registradas: ${data.faltas}',
            style: const TextStyle(color: Color(0xFF4B5563)),
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: percent,
            color: const Color(0xFF065F46),
            backgroundColor: Colors.grey.shade200,
            minHeight: 8,
          ),
        ],
      ),
    );
  }

  Widget _avaliacoesCard(DisciplineData data) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 8),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'AVALIAÇÕES',
            style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          if (data.avaliacoes.isEmpty)
            const Text(
              'Nenhuma avaliação relacionada encontrada para esta disciplina.',
            )
          else
            ...data.avaliacoes.map(
              (avaliacao) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _AvaliacaoTile(avaliacao: avaliacao),
              ),
            ),
          if (data.avaliacoes.isEmpty)
            const SizedBox.shrink()
          else
            const Text(
              'As avaliações são filtradas pelo vínculo do diário retornado pela API.',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
        ],
      ),
    );
  }

  Widget _analiseRiscoCard(DisciplineData data) {
    final nota = data.notaNumerica;
    final percentual = data.percentualFrequencia;
    final riskLevel = _riskLevel(nota, percentual);
    final riskProgress = _riskProgress(nota, percentual);
    final riskDescription = _riskDescription(riskLevel);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 8),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Análise de Risco',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Icon(Icons.circle, color: _riskColor(riskLevel), size: 14),
              const SizedBox(width: 8),
              Text(
                'NÍVEL DE RISCO',
                style: TextStyle(color: Colors.grey.shade600),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            riskLevel,
            style: TextStyle(
              color: _riskColor(riskLevel),
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(riskDescription),
          const SizedBox(height: 12),
          const Text('Confiabilidade', style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: riskProgress,
            color: const Color(0xFF065F46),
            backgroundColor: Colors.grey.shade200,
            minHeight: 8,
          ),
        ],
      ),
    );
  }

  String _riskLevel(double? nota, double? percentual) {
    if (nota == null && percentual == null) {
      return 'Sem dados suficientes';
    }

    final notaSegura = nota ?? 0;
    final percentualSegura = percentual ?? 0;

    if (notaSegura < 6 || percentualSegura < 75) {
      return 'Risco alto';
    }
    if (notaSegura < 7 || percentualSegura < 85) {
      return 'Atenção';
    }
    return 'Baixo';
  }

  double _riskProgress(double? nota, double? percentual) {
    final notaNormalizada = (nota ?? 0) / 10;
    final percentualNormalizado = (percentual ?? 0) / 100;
    final media = (notaNormalizada + percentualNormalizado) / 2;
    return media.clamp(0, 1);
  }

  String _riskDescription(String riskLevel) {
    switch (riskLevel) {
      case 'Risco alto':
        return 'A disciplina exige atenção imediata nas próximas avaliações e na frequência.';
      case 'Atenção':
        return 'O desempenho está estável, mas ainda exige acompanhamento regular.';
      case 'Baixo':
        return 'Seu desempenho está confortável no momento.';
      default:
        return 'Ainda não há dados suficientes para calcular o risco.';
    }
  }

  Color _riskColor(String riskLevel) {
    switch (riskLevel) {
      case 'Risco alto':
        return const Color(0xFFEF4444);
      case 'Atenção':
        return const Color(0xFFF59E0B);
      case 'Baixo':
        return const Color(0xFF10B981);
      default:
        return Colors.grey;
    }
  }
}

class _AvaliacaoTile extends StatelessWidget {
  final Map<String, dynamic> avaliacao;

  const _AvaliacaoTile({required this.avaliacao});

  @override
  Widget build(BuildContext context) {
    final descricao = avaliacao['descricao']?.toString() ?? 'Avaliação';
    final data = _formatDate(avaliacao['data']);

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F9F9),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          const Icon(Icons.event_note, color: Color(0xFF065F46)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  descricao,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(data, style: const TextStyle(color: Colors.grey)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(dynamic rawDate) {
    final parsed = DateTime.tryParse(rawDate?.toString() ?? '');
    if (parsed == null) {
      return 'Data não informada';
    }

    final day = parsed.day.toString().padLeft(2, '0');
    final month = parsed.month.toString().padLeft(2, '0');
    final year = parsed.year.toString();
    return '$day/$month/$year';
  }
}
