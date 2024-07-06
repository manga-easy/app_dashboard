class CredencialModel {
  final String? id;
  final String email;
  final String? token;
  final String? userId;

  CredencialModel({
    required this.email,
    this.id,
    this.token,
    this.userId,
  });

  CredencialModel.fromJson(Map<String, dynamic> json)
      : email = json['email'],
        token = json['token'],
        userId = json['userId'],
        id = 'CredencialModel';

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = 'CredencialModel';
    data['token'] = token;
    data['userId'] = userId;
    data['email'] = email;

    return data;
  }
}
