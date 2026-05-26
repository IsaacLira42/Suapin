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
      child: LayoutBuilder(
        builder: (context, constraints) {
          // Breakpoint para tablets/desktops
          if (constraints.maxWidth < 800) {
            return _buildMobileLayout();
          } else {
            return _buildDesktopLayout();
          }
        },
      ),
    );
  }

  // --- LAYOUT MOBILE (Uma única coluna) ---
  Widget _buildMobileLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TituloDaPagina(
          titulo: "Status Acadêmico",
          textoAuxiliar: "BEM-VINDO DE VOLTA",
          usuario: "LUCAS",
        ),
        AlertasCriticos(),
        const SizedBox(height: 32),
        HorarioHoje(aulas: mockAulasHoje),
        const SizedBox(height: 32),
        _buildSubjectSection(),
      ],
    );
  }

  // --- LAYOUT DESKTOP/TABLET (Duas colunas para economizar scroll) ---
  Widget _buildDesktopLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TituloDaPagina(
          titulo: "Status Acadêmico",
          textoAuxiliar: "BEM-VINDO DE VOLTA",
          usuario: "LUCAS",
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Coluna da Esquerda: Alertas e Matérias
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  AlertasCriticos(),
                  const SizedBox(height: 32),
                  _buildSubjectSection(),
                ],
              ),
            ),
            const SizedBox(width: 32),
            // Coluna da Direita: Horário (Timeline)
            Expanded(flex: 1, child: HorarioHoje(aulas: mockAulasHoje)),
          ],
        ),
      ],
    );
  }

  // Widget auxiliar para não repetir código da seção de matérias
  Widget _buildSubjectSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          "Visão Geral das Matérias",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16),
        SubjectCard(
          title: "Algoritmos",
          id: "CS102",
          grade: "8.5",
          absences: 12,
          icon: Icons.code,
        ),
        SubjectCard(
          title: "Inteligência Artif.",
          id: "PH105",
          grade: "9.2",
          absences: 5,
          icon: Icons.psychology,
        ),
        SubjectCard(
          title: "Banco de Dados",
          id: "DB301",
          grade: "7.8",
          absences: 18,
          icon: Icons.storage,
        ),
      ],
    );
  }
}
