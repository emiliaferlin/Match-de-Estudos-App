class Match {
  final int id;
  final int perfilId;
  final int sessaoId;
  final int score;
  final bool aprovado;

  Match({
    required this.id,
    required this.perfilId,
    required this.sessaoId,
    required this.score,
    required this.aprovado,
  });

  factory Match.fromMap(Map<String, dynamic> map) {
    return Match(
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
