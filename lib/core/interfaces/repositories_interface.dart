import 'package:dashboard_manga_easy/core/interfaces/local_data_interface.dart';

abstract class IRepo<T, B> {
  String get table;
  final ILocalData db;

  IRepo(this.db);

  T? get({required String id});

  Future<void> put({required T objeto});

  Future<void> remove({required String id});

  List<T> list({B where});
}
