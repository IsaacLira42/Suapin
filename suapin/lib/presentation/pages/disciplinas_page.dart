import 'package:flutter/material.dart';
import '../widgets/titulo_da_pagina.dart';
import '../widgets/discipline_card.dart';
import '../widgets/base_page.dart';

class DisciplinasPage extends StatelessWidget {
  const DisciplinasPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<DisciplineData> mocks = [
      DisciplineData(
        title: 'Inteligência Artificial',
        teacher: 'Prof. Dr. Ricardo Silva',
        percentual: 0.75,
        nota: '9.2',
        faltas: '02',
        tipo: 'Obrigatória',
        icon: Icons.psychology,
      ),
      DisciplineData(
        title: 'Cálculo Diferencial',
        teacher: 'Profa. Dra. Elena Santos',
        percentual: 0.40,
        nota: '7.5',
        faltas: '08',
        tipo: 'Obrigatória',
        icon: Icons.calculate,
      ),
      DisciplineData(
        title: 'Design de Interfaces',
        teacher: 'Prof. Marco Guedes',
        percentual: 0.90,
        nota: '10.0',
        faltas: '00',
        tipo: 'Eletiva',
        icon: Icons.design_services,
      ),
      DisciplineData(
        title: 'Estrutura de Dados',
        teacher: 'Prof. Dr. Fabio Lins',
        percentual: 0.62,
        nota: '8.4',
        faltas: '04',
        tipo: 'Obrigatória',
        icon: Icons.storage,
      ),
    ];

    return BasePage(
      currentIndex: 1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TituloDaPagina(
            titulo: 'Lista de Disciplinas',
            textoAuxiliar: 'SEMESTRE ATUAL: 2025.1',
            usuario: '',
          ),
          const SizedBox(height: 12),
          _buildOverview(),
          const SizedBox(height: 20),
          ...mocks.map((d) => DisciplineCard(data: d)).toList(),
        ],
      ),
    );
  }

  Widget _buildOverview() {
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
            children: const [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Média Geral', style: TextStyle(color: Colors.grey)),
                  SizedBox(height: 8),
                  Text(
                    '8.7',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF065F46),
                    ),
                  ),
                ],
              ),
              SizedBox(width: 8),
              Expanded(child: SizedBox()),
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
            children: const [
              Text(
                'Status do Semestre\nExcelente Desempenho',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Icon(Icons.verified, color: Colors.white),
            ],
          ),
        ),
      ],
    );
  }
}

class DisciplineData {
  final String title;
  final String teacher;
  final double percentual;
  final String nota;
  final String faltas;
  final String tipo;
  final IconData icon;

  DisciplineData({
    required this.title,
    required this.teacher,
    required this.percentual,
    required this.nota,
    required this.faltas,
    required this.tipo,
    required this.icon,
  });
}
