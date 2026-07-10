import 'package:flutter/material.dart';

import '../../domain/entities/discipline_data.dart';

DisciplineData mapBoletimToDiscipline(
  Map<String, dynamic> json, {
  List<dynamic> avaliacoes = const [],
}) {
  final nomeCompleto = json['disciplina']?.toString() ?? 'Disciplina';
  final codigoDiario = json['codigo_diario']?.toString() ?? '';
  final mediaNumerica = _readDouble(json['media_disciplina']);
  final percentualFrequencia = _readDouble(
    json['percentual_carga_horaria_frequentada'],
  );
  final faltasNumericas = _readInt(json['numero_faltas']);
  final avaliacoesDaDisciplina = filterAvaliacoesDaDisciplina(
    codigoDiario,
    avaliacoes,
  );

  return DisciplineData(
    title: _shortenSubjectName(nomeCompleto),
    nomeCompleto: nomeCompleto,
    teacher: _extractTeacher(json),
    percentual: _normalizePercentual(percentualFrequencia),
    percentualFrequencia: percentualFrequencia,
    nota: _formatGrade(mediaNumerica),
    notaNumerica: mediaNumerica,
    faltas: _formatAbsences(faltasNumericas),
    faltasNumericas: faltasNumericas,
    tipo: _extractTipo(json),
    icon: _iconForDiscipline(nomeCompleto, codigoDiario),
    codigoDiario: codigoDiario,
    rawBoletim: json,
    avaliacoes: avaliacoesDaDisciplina,
  );
}

List<DisciplineData> mapBoletimListToDisciplines(
  List<dynamic> boletim,
  List<dynamic> avaliacoes,
) {
  return boletim
      .whereType<Map>()
      .map((item) => Map<String, dynamic>.from(item))
      .map((item) => mapBoletimToDiscipline(item, avaliacoes: avaliacoes))
      .toList();
}

List<Map<String, dynamic>> filterAvaliacoesDaDisciplina(
  String codigoDiario,
  List<dynamic> avaliacoes,
) {
  if (codigoDiario.isEmpty) {
    return const [];
  }

  // A API do SUAP expõe o vínculo da avaliação com a disciplina via `diario`.
  // Se esse relacionamento mudar, a adaptação deve ficar concentrada aqui.
  return avaliacoes
      .whereType<Map>()
      .map((item) {
        return Map<String, dynamic>.from(item);
      })
      .where((avaliacao) {
        return avaliacao['diario']?.toString() == codigoDiario;
      })
      .toList();
}

double? calculateAverageGrade(List<DisciplineData> disciplines) {
  final grades = disciplines
      .map((discipline) => discipline.notaNumerica)
      .whereType<double>()
      .toList();

  if (grades.isEmpty) {
    return null;
  }

  final sum = grades.fold<double>(
    0,
    (accumulator, grade) => accumulator + grade,
  );
  return sum / grades.length;
}

String classifySemesterStatus(double? average) {
  if (average == null) {
    return 'Sem notas suficientes';
  }

  if (average >= 8.5) {
    return 'Excelente desempenho';
  }
  if (average >= 7) {
    return 'Bom desempenho';
  }
  if (average >= 6) {
    return 'Atenção';
  }
  return 'Risco de reprovação';
}

String _shortenSubjectName(String nomeCompleto) {
  if (!nomeCompleto.contains('-')) {
    return nomeCompleto;
  }

  return nomeCompleto.split('-').last.trim();
}

String _extractTeacher(Map<String, dynamic> json) {
  final candidates = [
    json['professor'],
    json['docente'],
    json['teacher'],
    json['nome_professor'],
  ];

  final teacher = candidates
      .map((value) => value?.toString().trim())
      .firstWhere(
        (value) => value != null && value.isNotEmpty,
        orElse: () => null,
      );

  // O boletim não fornece o professor de forma confiável em todos os cenários.
  return teacher ?? 'Professor não informado';
}

String _extractTipo(Map<String, dynamic> json) {
  final candidates = [json['tipo'], json['natureza'], json['categoria']];

  final tipo = candidates
      .map((value) => value?.toString().trim())
      .firstWhere(
        (value) => value != null && value.isNotEmpty,
        orElse: () => null,
      );

  // A API utilizada neste fluxo não expõe o tipo de disciplina com garantia.
  return tipo ?? 'Não informado';
}

double _normalizePercentual(double? percentualFrequencia) {
  if (percentualFrequencia == null) {
    return 0;
  }

  final normalized = percentualFrequencia > 1
      ? percentualFrequencia / 100
      : percentualFrequencia;
  return normalized.clamp(0, 1).toDouble();
}

String _formatGrade(double? grade) {
  if (grade == null) {
    return 'N/A';
  }

  return grade.toStringAsFixed(1);
}

String _formatAbsences(int? absences) {
  if (absences == null) {
    return '00';
  }

  return absences.toString().padLeft(2, '0');
}

double? _readDouble(dynamic value) {
  if (value == null) {
    return null;
  }

  if (value is num) {
    return value.toDouble();
  }

  return double.tryParse(value.toString());
}

int? _readInt(dynamic value) {
  if (value == null) {
    return null;
  }

  if (value is int) {
    return value;
  }

  if (value is num) {
    return value.round();
  }

  return int.tryParse(value.toString());
}

IconData _iconForDiscipline(String nomeCompleto, String codigoDiario) {
  const icons = [
    Icons.book,
    Icons.psychology,
    Icons.calculate,
    Icons.storage,
    Icons.design_services,
    Icons.science,
    Icons.computer,
  ];

  final seed = codigoDiario.isNotEmpty
      ? codigoDiario.hashCode
      : nomeCompleto.hashCode;
  return icons[seed.abs() % icons.length];
}
