import 'package:flutter/material.dart';
import 'package:suapin/presentation/widgets/horario_hoje.dart';
import '../widgets/alertas_criticos.dart';
import '../widgets/base_page.dart';
import '../widgets/titulo_da_pagina.dart';
import '../widgets/subject_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BasePage(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Título da Página
          const TituloDaPagina(
            titulo: "Status Acadêmico",
            textoAuxiliar: "BEM-VINDO DE VOLTA",
          ),
          // Alertas Críticos
          AlertasCriticos(),
          const SizedBox(height: 32),
          // O widget de Horário de Hoje pode ser adicionado aqui
          HorarioHoje(aulas: mockAulasHoje),
          const SizedBox(height: 32),
          // Visão Geral das Matérias
          const Text(
            "Visão Geral das Matérias",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SubjectCard(
            title: "Algoritmos",
            id: "CS102",
            grade: "8.5",
            absences: 12,
            icon: Icons.code,
          ),
          const SubjectCard(
            title: "Inteligência Artif.",
            id: "PH105",
            grade: "9.2",
            absences: 5,
            icon: Icons.psychology,
          ),
          const SizedBox(height: 20),
          // Botões de Ações Rápidas
        ],
      ),
    );
  }
}
