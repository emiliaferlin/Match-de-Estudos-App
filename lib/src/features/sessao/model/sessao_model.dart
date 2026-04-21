class SessaoModel {
  final int? id;
  final String? titulo;
  final String? disciplina;
  final String? nivel;
  final String? estilo;
  final String? dataHoraInicio;
  final int? duracaoMinutos;
  final int? vagas;

  SessaoModel({
    this.id,
    this.titulo,
    this.disciplina,
    this.nivel,
    this.estilo,
    this.dataHoraInicio,
    this.duracaoMinutos,
    this.vagas,
  });

  factory SessaoModel.fromMap(Map<String, dynamic> map) {
    return SessaoModel(
      id: map['id'] as int,
      titulo: map['titulo'] as String,
      disciplina: map['disciplina'] as String,
      nivel: map['nivel'] as String,
      estilo: map['estilo'] as String,
      dataHoraInicio: map['dataHoraInicio'] as String,
      duracaoMinutos: map['duracaoMinutos'] as int,
      vagas: map['vagas'] as int,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'titulo': titulo,
      'disciplina': disciplina,
      'nivel': nivel,
      'estilo': estilo,
      'dataHoraInicio': dataHoraInicio,
      'duracaoMinutos': duracaoMinutos,
      'vagas': vagas,
    };
  }
}
