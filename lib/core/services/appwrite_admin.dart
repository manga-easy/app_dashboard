import 'package:dart_appwrite/dart_appwrite.dart';
import 'package:dashboard_manga_easy/core/config/app_config.dart';
import 'package:dashboard_manga_easy/core/interfaces/service.dart';

class AppwriteAdmin extends IService {
  late Client client;
  late Account account;
  late Databases database;
  late Users users;

  @override
  Future<void> initialise() async {
    client = Client();
    client
        .setEndpoint(AppConfig.ipserver) // Your Appwrite Endpoint
        .setProject(AppConfig.projectID) // Your project ID
        .setKey(AppConfig.keyAppwrite);

    account = Account(client);
    users = Users(client);
    database = Databases(client, databaseId: 'default');
  }
}
