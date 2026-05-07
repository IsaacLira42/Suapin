import 'package:flutter/material.dart';

class AlertasCriticos extends StatelessWidget {
  final List<Map<String, String>> alertas = [
    {
      "nome": "Exame Final Próximo",
      "dado": "3 Dias",
      "materia": "Cálculo Diferencial e Integral III",
    },
    {
      "nome": "Limite de Faltas",
      "dado": "22%",
      "materia": "Estruturas de Dados Avançadas",
    },
  ];

  AlertasCriticos({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // Removendo largura fixa para deixar o layout decidir,
      // ou use width: double.infinity se quiser forçar o container cinza também.
      width: double.infinity,
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F5F9),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        // Isso garante que os filhos da Column tentem ocupar toda a largura
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: const [
                  Icon(Icons.error, color: Color(0xFFB91C1C)),
                  SizedBox(width: 8),
                  Text(
                    "Alertas Críticos",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFFEE2E2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  "2 PRIORIDADES",
                  style: TextStyle(
                    color: Color(0xFFB91C1C),
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Mapeia a lista para os cards
          ...alertas.map((alerta) => _buildAlertaCard(alerta)).toList(),
        ],
      ),
    );
  }

  Widget _buildAlertaCard(Map<String, String> alerta) {
    return Container(
      width: double.infinity, // <--- GARANTE A LARGURA 100%
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: const Border(
          left: BorderSide(color: Color(0xFFB91C1C), width: 4),
        ),
        // Adicionando uma sombra leve para combinar com o Figma
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            alerta["nome"]!,
            style: const TextStyle(
              color: Color(0xFF6B7280), // Cinza mais próximo do Figma
              fontWeight: FontWeight.w500,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            alerta["dado"]!,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFFB91C1C),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            alerta["materia"]!,
            style: const TextStyle(color: Color(0xFF4B5563), fontSize: 14),
          ),
        ],
      ),
    );
  }
}
