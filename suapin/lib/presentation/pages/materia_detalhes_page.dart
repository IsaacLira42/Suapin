import 'package:flutter/material.dart';
import 'disciplinas_page.dart';

class MateriaDetalhesPage extends StatelessWidget {
  final DisciplineData data;

  const MateriaDetalhesPage({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F9F9),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black87),
        title: Text(data.title, style: const TextStyle(color: Colors.black87)),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTabs(),
              const SizedBox(height: 16),
              _mediaCard(),
              const SizedBox(height: 12),
              _presencaCard(),
              const SizedBox(height: 12),
              _evolucaoCard(),
              const SizedBox(height: 12),
              _analiseRiscoCard(),
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

  Widget _mediaCard() {
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

  Widget _presencaCard() {
    final percent = 0.92;
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
            '${(percent * 100).round()}%',
            style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
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

  Widget _evolucaoCard() {
    // Simple bar chart mock
    final bars = [0.35, 0.45, 0.4, 0.55, 0.6, 0.5, 0.78];
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
            'Evolução do Conhecimento',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 140,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: List.generate(bars.length, (i) {
                final h = bars[i];
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6.0),
                    child: Container(
                      height: 140 * h,
                      decoration: BoxDecoration(
                        color: i == bars.length - 1
                            ? const Color(0xFF065F46)
                            : Colors.green.shade100,
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget _analiseRiscoCard() {
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
            children: const [
              Icon(Icons.circle, color: Color(0xFF10B981)),
              SizedBox(width: 8),
              Text('NÍVEL DE RISCO', style: TextStyle(color: Colors.grey)),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            'Baixo',
            style: TextStyle(
              color: Color(0xFF065F46),
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Seu desempenho está 15% acima da zona crítica. Continue mantendo a frequência nas aulas práticas para garantir a aprovação direta.',
          ),
          const SizedBox(height: 12),
          const Text('Conkiktência', style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: 0.9,
            color: const Color(0xFF065F46),
            backgroundColor: Colors.grey.shade200,
            minHeight: 8,
          ),
        ],
      ),
    );
  }
}
