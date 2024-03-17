class CredencialModel {
  final String? id;
  final String email;
  final String tokenJwt;

  CredencialModel({
    required this.tokenJwt,
    required this.email,
    this.id,
  });

  CredencialModel.fromJson(Map<String, dynamic> json)
      : email = json['email'],
        tokenJwt = json['tokenJwt'],
        id = 'CredencialModel';

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = 'CredencialModel';
    data['email'] = email;
    data['tokenJwt'] = tokenJwt;
    return data;
  }
}
