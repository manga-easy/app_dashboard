import 'package:appwrite/appwrite.dart';

import 'package:dashboard_manga_easy/core/interfaces/service.dart';

class AppwriteClient extends IService {
  late Client client;
  late Account account;
  late Databases database;

  @override
  Future<void> initialise() async {
    client = Client();
    client
        .setEndpoint(AppConfig.ipserver) // Your Appwrite Endpoint
        .setProject(AppConfig.projectID)
        .setSelfSigned(); // Your project ID

    account = Account(client);
    database = Databases(client, databaseId: 'default');
  }
}
