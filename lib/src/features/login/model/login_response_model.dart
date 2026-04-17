class LoginResponseModel {
  final String? token;

  LoginResponseModel({this.token});

  factory LoginResponseModel.fromMap(Map<String, dynamic> map) {
    return LoginResponseModel(token: map['token'] as String);
  }

  Map<String, dynamic> toMap() {
    return {'token': token};
  }
}
