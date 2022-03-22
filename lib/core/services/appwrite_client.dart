import 'package:appwrite/appwrite.dart';
import 'package:dashboard_manga_easy/core/config/app_config.dart';
import 'package:get/get.dart';

class AppwriteClient extends GetxService {
  late Client client;
  late Account account;
  late Database database;

  Future<AppwriteClient> inicia() async {
    client = Client();
    client
        .setEndpoint(AppConfig.ipserver) // Your Appwrite Endpoint
        .setProject(AppConfig.projectID); // Your project ID

    account = Account(client);
    database = Database(client);
    return this;
  }

  @override
  void onClose() {
    super.onClose();
  }

  @override
  void onInit() {
    super.onInit();
  }
}
