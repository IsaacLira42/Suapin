import 'package:flutter/material.dart';

class TituloDaPagina extends StatelessWidget {
  final String titulo;
  final String textoAuxiliar;

  const TituloDaPagina({
    super.key,
    required this.titulo,
    required this.textoAuxiliar,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "$textoAuxiliar, LUCAS",
                style: const TextStyle(
                  color: Color(0xFF059669),
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  letterSpacing: 1.1,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                titulo,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1F2937),
                ),
              ),
            ],
          ),
          const CircleAvatar(
            radius: 24,
            backgroundImage: NetworkImage(
              'https://github.com/isaaclira.png',
            ), // Mock do seu perfil
          ),
        ],
      ),
    );
  }
}
