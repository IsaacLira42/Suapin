class AnotacaoModel {
  final int? id;
  final String titulo;
  final String conteudo;
  final String disciplina;

  const AnotacaoModel({
    this.id,
    required this.titulo,
    required this.conteudo,
    required this.disciplina,
  });

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'titulo': titulo,
      'conteudo': conteudo,
      'disciplina': disciplina,
    };
  }

  factory AnotacaoModel.fromMap(Map<String, dynamic> map) {
    return AnotacaoModel(
      id: map['id'] as int?,
      titulo: map['titulo']?.toString() ?? '',
      conteudo: map['conteudo']?.toString() ?? '',
      disciplina: map['disciplina']?.toString() ?? '',
    );
  }
}
