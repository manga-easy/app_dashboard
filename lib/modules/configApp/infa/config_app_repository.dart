import 'package:dashboard_manga_easy/modules/configApp/domain/repositories/config_app_repository_inter.dart';
import 'package:sdk_manga_easy/sdk_manga_easy.dart';

class ConfigAppRepository extends IConfigAppRepository {
  ConfigAppRepository(super.appwriteAdmin);

  @override
  Future<ConfigAppModel> get() async {
    var ret = await appwriteAdmin.database.listDocuments(
      collectionId: ConfigAppModel.collectionId,
      limit: 1,
    );
    return ConfigAppModel.fromJson(ret.documents.first.data);
  }

  @override
  Future<void> update(ConfigAppModel configApp) async {
    await appwriteAdmin.database.updateDocument(
      collectionId: ConfigAppModel.collectionId,
      documentId: configApp.id!,
      data: configApp.toJson(),
    );
  }
}
