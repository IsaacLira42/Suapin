import 'package:flutter/material.dart';

class DisciplineData {
  final String title;
  final String nomeCompleto;
  final String teacher;
  final double percentual;
  final double? percentualFrequencia;
  final String nota;
  final double? notaNumerica;
  final String faltas;
  final int? faltasNumericas;
  final String tipo;
  final IconData icon;
  final String codigoDiario;
  final Map<String, dynamic> rawBoletim;
  final List<Map<String, dynamic>> avaliacoes;

  DisciplineData({
    required this.title,
    required this.nomeCompleto,
    required this.teacher,
    required this.percentual,
    required this.percentualFrequencia,
    required this.nota,
    required this.notaNumerica,
    required this.faltas,
    required this.faltasNumericas,
    required this.tipo,
    required this.icon,
    required this.codigoDiario,
    required this.rawBoletim,
    required this.avaliacoes,
  });
}
