import 'package:flutter/material.dart';

class AlertasCriticos extends StatelessWidget {
  // Agora a lista vem de fora (da HomePage)
  final List<Map<String, String>> alertas;

  const AlertasCriticos({super.key, required this.alertas});

  @override
  Widget build(BuildContext context) {
    // Se não tiver alertas, podemos não mostrar o componente ou mostrar um estado vazio
    if (alertas.isEmpty) {
      return const SizedBox.shrink(); // Esconde o componente
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F5F9),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
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
                child: Text(
                  "${alertas.length} PRIORIDADE${alertas.length > 1 ? 'S' : ''}",
                  style: const TextStyle(
                    color: Color(0xFFB91C1C),
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...alertas.map((alerta) => _buildAlertaCard(alerta)).toList(),
        ],
      ),
    );
  }

  Widget _buildAlertaCard(Map<String, String> alerta) {
    // Mesma implementação original, só ajustei o build
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: const Border(
          left: BorderSide(color: Color(0xFFB91C1C), width: 4),
        ),
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
              color: Color(0xFF6B7280),
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
