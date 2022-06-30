import 'package:dashboard_manga_easy/core/services/appwrite_admin.dart';

class DataRepoExternal<T> {
  List<T> data;
  int total;
  DataRepoExternal({required this.data, required this.total});
}

abstract class IRepoExternal<T, B> {
  final AppwriteAdmin db;
  String get table;

  IRepoExternal(this.db);

  Future<T?> getDocument({required String id});

  Future<void> updateDocument({required T objeto});

  Future<void> deletDocument({required String id});

  Future<void> creatDocument({required T objeto});

  Future<DataRepoExternal<T>> listDocument({B? where});
}
