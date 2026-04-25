import 'package:flutter/material.dart';

class AlertasCriticos extends StatelessWidget {
  // ! Substitui temporariamente por dados mokados
  // final List<Map<String, String>> alertas;
  // const AlertasCriticos({super.key, required this.alertas});

  final List<Map<String, String>> alertas = [
    {
      "nome": "Exame Final Próximo",
      "dado": "3 Dias",
      "materia": "Cálculo Diferencial e Integral III",
    },
    {
      "nome": "Trabalho Atrasado",
      "dado": "2 Dias",
      "materia": "Estrutura de Dados",
    },
  ];
  AlertasCriticos({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200], // fundo cinza claro (container maior)
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(Icons.warning, color: Colors.red), // ícone de alerta
              SizedBox(width: 8),
              Text(
                "Alertas Críticos",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Renderizando lista de alertas
          Column(
            children: alertas.map((alerta) {
              return Container(
                width: double.infinity,
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.all(16),
                color: Colors.white, // fundo branco (container menor)
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      alerta["nome"]!,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text(alerta["dado"]!),
                    const SizedBox(height: 4),
                    Text(
                      alerta["materia"]!,
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
