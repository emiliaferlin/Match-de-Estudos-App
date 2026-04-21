class MatchModel {
  final int? id;
  final int? perfilId;
  final int? sessaoId;
  final int? score;
  final bool? aprovado;

  MatchModel({
    this.id,
    this.perfilId,
    this.sessaoId,
    this.score,
    this.aprovado,
  });

  factory MatchModel.fromMap(Map<String, dynamic> map) {
    return MatchModel(
      id: map['id'] as int,
      perfilId: map['perfilId'] as int,
      sessaoId: map['sessaoId'] as int,
      score: map['score'] as int,
      aprovado: map['aprovado'] as bool,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'perfilId': perfilId,
      'sessaoId': sessaoId,
      'score': score,
      'aprovado': aprovado,
    };
  }
}
