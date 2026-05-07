import 'package:flutter/material.dart';

// 1. Modelo de dados simulando o que viria do backend
class AulaModel {
  final String horario;
  final String disciplina;
  final String status;
  final TimelineState state;

  AulaModel({
    required this.horario,
    required this.disciplina,
    required this.status,
    required this.state,
  });
}

// 2. Mock de dados (Simulação do Backend)
final List<AulaModel> mockAulasHoje = [
  AulaModel(
    horario: "08:00 - 09:40",
    disciplina: "Física Experimental II",
    status: "Concluído",
    state: TimelineState.done,
  ),
  AulaModel(
    horario: "10:00 - 11:40",
    disciplina: "Arquitetura de Computadores",
    status: "Em andamento • Lab 04",
    state: TimelineState.doing,
  ),
  AulaModel(
    horario: "14:00 - 15:40",
    disciplina: "Inglês Instrumental",
    status: "Próximo",
    state: TimelineState.todo,
  ),
];

class HorarioHoje extends StatelessWidget {
  final List<AulaModel> aulas;

  const HorarioHoje({super.key, required this.aulas});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Horário de Hoje",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          // Renderização dinâmica baseada na lista
          ...aulas.asMap().entries.map((entry) {
            int index = entry.key;
            AulaModel aula = entry.value;
            bool isLast = index == aulas.length - 1;

            return _buildTimelineItem(
              time: aula.horario,
              title: aula.disciplina,
              status: aula.status,
              state: aula.state,
              isLast: isLast,
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildTimelineItem({
    required String time,
    required String title,
    required String status,
    required TimelineState state,
    bool isLast = false,
  }) {
    Color mainColor;
    Widget icon;

    switch (state) {
      case TimelineState.done:
        mainColor = const Color(0xFFD1FAE5);
        icon = const Icon(Icons.check, size: 14, color: Color(0xFF059669));
        break;
      case TimelineState.doing:
        mainColor = const Color(0xFFD1FAE5);
        icon = Container(
          width: 12,
          height: 12,
          decoration: const BoxDecoration(
            color: Color(0xFF059669),
            shape: BoxShape.circle,
          ),
        );
        break;
      case TimelineState.todo:
        mainColor = const Color(0xFFF1F5F9);
        icon = const SizedBox();
        break;
    }

    return IntrinsicHeight(
      child: Row(
        children: [
          Column(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: mainColor,
                  shape: BoxShape.circle,
                  border: state == TimelineState.doing
                      ? Border.all(
                          color: const Color(0xFF059669).withOpacity(0.2),
                          width: 4,
                        )
                      : null,
                ),
                child: Center(child: icon),
              ),
              if (!isLast)
                Expanded(
                  child: Container(width: 2, color: const Color(0xFFE2E8F0)),
                ),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    time,
                    style: TextStyle(
                      color: state == TimelineState.todo
                          ? Colors.grey
                          : const Color(0xFF059669),
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: state == TimelineState.done
                          ? Colors.grey
                          : const Color(0xFF1F2937),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    status,
                    style: TextStyle(
                      color: state == TimelineState.doing
                          ? const Color(0xFF059669)
                          : Colors.grey,
                      fontSize: 14,
                      fontWeight: state == TimelineState.doing
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

enum TimelineState { done, doing, todo }
