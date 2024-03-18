class User {
  String? id;
  String name;
  String registration;
  bool status;
  String passwordUpdate;
  String email;
  bool emailVerification;
  Prefs prefs;

  User({
    this.id,
    required this.name,
    required this.registration,
    required this.status,
    required this.passwordUpdate,
    required this.email,
    required this.emailVerification,
    required this.prefs,
  });

  User.fromJson(dynamic json)
      : id = json['\$id'],
        name = json['name'],
        registration = json['registration'].toString(),
        status = json['status'] is bool ? json['status'] : true,
        passwordUpdate = json['passwordUpdate'].toString(),
        email = json['email'],
        prefs = Prefs.fromJson(json['prefs']['data'] ?? json['prefs']),
        emailVerification = json['emailVerification'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['\$id'] = id;
    data['name'] = name;
    data['registration'] = registration;
    data['status'] = status;
    data['passwordUpdate'] = passwordUpdate;
    data['email'] = email;
    data['prefs'] = prefs.toJson();
    data['emailVerification'] = emailVerification;
    return data;
  }
}

class Prefs {
  String provider;
  String tokenFcm;
  Prefs({
    required this.provider,
    required this.tokenFcm,
  });
  Prefs.fromJson(dynamic json)
      : tokenFcm = json['tokenFcm'] ?? '',
        provider = json['provider'] ?? '';

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['provider'] = provider;
    data['tokenFcm'] = tokenFcm;
    return data;
  }
}
