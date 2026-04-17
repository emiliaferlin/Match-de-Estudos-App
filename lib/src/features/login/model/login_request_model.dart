class LoginRequestModel {
  final String? email;
  final String? senha;

  LoginRequestModel({this.email, this.senha});

  factory LoginRequestModel.fromMap(Map<String, dynamic> map) {
    return LoginRequestModel(
      email: map['email'] as String,
      senha: map['senha'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {'email': email, 'senha': senha};
  }
}
