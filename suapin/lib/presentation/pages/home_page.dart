import 'package:flutter/material.dart';
import 'package:suapin/presentation/widgets/alertas_criticos.dart';
import 'package:suapin/presentation/widgets/base_page.dart';
import 'package:suapin/presentation/widgets/titulo_da_pagina.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BasePage(
      child: Column(
        children: [
          TituloDaPagina(
            titulo: "Status Acadêmico",
            textoAuxiliar: "BEM-VINDO DE VOLTA",
          ),
          AlertasCriticos(),
        ],
      ),
    );
  }
}
