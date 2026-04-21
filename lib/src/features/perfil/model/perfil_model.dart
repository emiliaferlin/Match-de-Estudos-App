class PerfilModel {
  final int? id;
  final String? nome;
  final int? idade;
  final String? disciplina;
  final String? nivel;
  final String? estilo;

  PerfilModel({
    this.id,
    this.nome,
    this.idade,
    this.disciplina,
    this.nivel,
    this.estilo,
  });

  factory PerfilModel.fromMap(Map<String, dynamic> map) {
    return PerfilModel(
      id: map['id'] as int,
      nome: map['nome'] as String,
      idade: map['idade'] as int,
      disciplina: map['disciplina'] as String,
      nivel: map['nivel'] as String,
      estilo: map['estilo'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'idade': idade,
      'disciplina': disciplina,
      'nivel': nivel,
      'estilo': estilo,
    };
  }
}
