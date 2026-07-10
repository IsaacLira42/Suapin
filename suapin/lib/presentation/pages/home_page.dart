import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/services/suap_api_service.dart';
import '../bloc/home_cubit.dart';
import '../bloc/auth_cubit.dart';
import 'package:suapin/presentation/widgets/horario_hoje.dart';
import '../widgets/alertas_criticos.dart';
import '../widgets/base_page.dart';
import '../widgets/titulo_da_pagina.dart';
import '../widgets/subject_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  List<Map<String, String>> _gerarAlertas(HomeLoaded state) {
    List<Map<String, String>> alertas = [];

    // Regra 1: Faltas Altas (Boletim)
    for (var mat in state.boletim) {
      double pctFrequencia =
          mat['percentual_carga_horaria_frequentada'] ?? 100.0;
      if (pctFrequencia < 75.0) {
        alertas.add({
          "nome": "Risco de Reprovação por Falta",
          "dado": "${100 - pctFrequencia}% de Faltas",
          "materia": mat['disciplina'].toString().split('-').last.trim(),
        });
      }

      // Regra 2: Nota Baixa (Exemplo < 60 se a média já existir)
      if (mat['media_disciplina'] != null && mat['media_disciplina'] < 60) {
        alertas.add({
          "nome": "Desempenho Crítico",
          "dado": "Nota: ${mat['media_disciplina']}",
          "materia": mat['disciplina'].toString().split('-').last.trim(),
        });
      }
    }

    // Regra 3: Provas Próximas (Avaliações)
    final hoje = DateTime.now();
    for (var avaliacao in state.avaliacoes) {
      try {
        final dataProva = DateTime.parse(avaliacao['data']);
        final diferenca = dataProva.difference(hoje).inDays;

        if (diferenca >= 0 && diferenca <= 3) {
          // Provas nos próximos 3 dias
          // Busca o nome da matéria pelo ID do diário cruzando com o boletim
          final diarioId = avaliacao['diario'].toString();
          final matBoletim = state.boletim.firstWhere(
            (b) => b['codigo_diario'].toString() == diarioId,
            orElse: () => {'disciplina': 'Desconhecida'},
          );

          alertas.add({
            "nome": "Avaliação Próxima",
            "dado": diferenca == 0 ? "HOJE!" : "Em $diferenca dias",
            "materia":
                "${avaliacao['descricao']} - ${matBoletim['disciplina'].toString().split('-').last.trim()}",
          });
        }
      } catch (e) {
        // Ignora erro de formatação de data
      }
    }

    // Limita a mostrar no máximo os 3 alertas mais críticos para não quebrar o layout
    return alertas.take(3).toList();
  }

  List<AulaModel> _gerarAulasDeHoje(HomeLoaded state) {
    // Mapeamento dos códigos de horário para o horário real
    final Map<String, String> horariosMap = {
      '12': '07:00 - 08:30',
      '34': '09:00 - 10:30',
      '56': '10:30 - 12:00',
      '78': '13:30 - 15:00',
    };

    List<AulaModel> aulasHoje = [];
    final int numeroDiaSuap = DateTime.now().weekday + 1;
    final String diaStr = numeroDiaSuap.toString();

    for (var turma in state.turmas) {
      final String horariosStr = turma['horarios_de_aula']?.toString() ?? "";

      // Divide a string pelos dias (ex: "3M34 / 4M56")
      final listaHorarios = horariosStr
          .split('/')
          .map((s) => s.trim())
          .toList();

      // Procura o bloco que começa com o dia de hoje
      final blocoHoje = listaHorarios.firstWhere(
        (horario) => horario.startsWith(diaStr),
        orElse: () => '',
      );

      if (blocoHoje.isNotEmpty) {
        // Extrai o código do horário (posição 2 em diante)
        // Ex: "3M56" -> "56"
        final String codigoHorario = blocoHoje.length > 2
            ? blocoHoje.substring(2)
            : '';

        // Mapeia para o horário real ou usa o código cru se não encontrado
        final String horarioExibicao =
            horariosMap[codigoHorario] ?? codigoHorario;

        aulasHoje.add(
          AulaModel(
            horario: horarioExibicao, // Agora mostra o horário real!
            disciplina: turma['descricao'],
            status: turma['locais_de_aula'].isNotEmpty
                ? turma['locais_de_aula'][0]
                : "Local indefinido",
            state: TimelineState.todo,
          ),
        );
      }
    }

    return aulasHoje;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      // Cria o Cubit e já manda carregar os dados assim que a tela constrói!
      create: (context) => HomeCubit(SuapApiService())..carregarDados(),
      child: BasePage(
        currentIndex: 0,
        // O Consumer permite escutar erros (listener) e construir a tela (builder)
        child: BlocConsumer<HomeCubit, HomeState>(
          listener: (context, state) {
            if (state is HomeError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.red,
                ),
              );
              // Se o erro for de sessão expirada (Atividade 2), manda pro login
              if (state.message.contains('expirada')) {
                context.read<AuthCubit>().logout();
              }
            }
          },
          builder: (context, state) {
            if (state is HomeLoading || state is HomeInitial) {
              return const Center(
                child: CircularProgressIndicator(color: Color(0xFF006D42)),
              );
            }

            if (state is HomeError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 64,
                      color: Colors.red,
                    ),
                    const SizedBox(height: 16),
                    Text(state.message, textAlign: TextAlign.center),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () =>
                          context.read<HomeCubit>().carregarDados(),
                      child: const Text('Tentar Novamente'),
                    ),
                  ],
                ),
              );
            }

            if (state is HomeLoaded) {
              return _buildMobileLayout(state);
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  // Passamos o state (HomeLoaded) para os layouts
  Widget _buildMobileLayout(HomeLoaded state) {
    return SingleChildScrollView(
      child: Column(
        children: [
          AlertasCriticos(alertas: _gerarAlertas(state)), // AQUI A CONEXÃO
          const SizedBox(height: 32),
          HorarioHoje(aulas: _gerarAulasDeHoje(state)), // AQUI A CONEXÃO
          _buildSubjectSection(state),
        ],
      ),
    );
  }

  // A mágica acontece aqui: Transformando o JSON (Boletim) em SubjectCards reais!
  Widget _buildSubjectSection(HomeLoaded state) {
    final boletim = state.boletim;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Visão Geral das Matérias",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        ...boletim.map((disciplina) {
          final nomeCompleto = disciplina['disciplina'].toString();
          final nomeCurto = nomeCompleto.contains('-')
              ? nomeCompleto.split('-')[1].trim()
              : nomeCompleto;

          return Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: SubjectCard(
              title: nomeCurto,
              id: disciplina['codigo_diario'].toString(),
              // Se media for null, mostra "N/A"
              grade: disciplina['media_disciplina']?.toString() ?? "N/A",
              absences: disciplina['numero_faltas'] ?? 0,
              icon: Icons.book,
            ),
          );
        }).toList(),
      ],
    );
  }
}
