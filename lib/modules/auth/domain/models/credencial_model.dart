class CredencialModel {
  final String? id;
  final String email;

  CredencialModel({
    required this.email,
    this.id,
  });

  CredencialModel.fromJson(Map<String, dynamic> json)
      : email = json['email'],
        id = 'CredencialModel';

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = 'CredencialModel';
    data['email'] = email;

    return data;
  }
}
