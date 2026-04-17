class UsuarioModel {
  final int? id;
  final String? email;
  final String? senha;

  UsuarioModel({this.id, this.email, this.senha});

  factory UsuarioModel.fromMap(Map<String, dynamic> map) {
    return UsuarioModel(
      id: map['id'] as int,
      email: map['email'] as String,
      senha: map['senha'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'email': email, 'senha': senha};
  }
}
