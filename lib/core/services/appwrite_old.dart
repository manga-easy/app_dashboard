import 'package:dart_appwriteold/dart_appwrite.dart';

class AppwriteOld {
  late Client client;
  late Account account;
  late Database database;
  late Users users;
  static const String ipserver = 'https://193.123.102.234/v1';
  static const projectID = '617844c305e60';
  static const keyAppwrite =
      '23f3c25d50c413ffa3e927bd23934f08107a1aee1f02597ca5d1eba7a348577398c1ca1161ccf760b32214f88cb97099ecdc8f8d7ac390b9715c2decd3a3c15f4fde8169d22185c187dc3e3cebeed6281e2c19ea700a56016d7f81458ad0095f4422a0f11cb80f11b707d6bfd73565ae3a4854b7230a816f8a3995644c1c9f9f';
  void inicia() {
    client = Client();
    client
            .setEndpoint(ipserver) // Your Appwrite Endpoint
            .setProject(projectID)
            .setKey(keyAppwrite) // Your project ID
        ;
    users = Users(client);
    account = Account(client);
    database = Database(client);
  }
}
