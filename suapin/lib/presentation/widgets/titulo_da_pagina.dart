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
    return Column(
      children: [Text(textoAuxiliar), SizedBox(height: 8), Text(titulo)],
    );
  }
}
