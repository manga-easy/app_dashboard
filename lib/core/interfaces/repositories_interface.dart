import 'package:dashboard_manga_easy/core/interfaces/local_data_interface.dart';

abstract class IRepo<T, B> {
  final ILocalData db;

  IRepo(this.db);

  T? getData({required String id});

  Future<void> putData({required T objeto, required String id});

  Future<void> removeData({required String id});

  List<T> getAllData({B where});
}
