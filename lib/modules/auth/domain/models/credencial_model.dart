class CredencialModel {
  String? id;
  String email;
  DateTime datetime;

  CredencialModel({required this.datetime, required this.email, this.id});

  CredencialModel.fromJson(Map<String, dynamic> json)
      : email = json['email'],
        datetime = json['datetime'],
        id = 'CredencialModel';

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = 'CredencialModel';
    data['email'] = email;
    data['datetime'] = datetime;
    return data;
  }
}
