import 'package:dashboard_manga_easy/core/services/persistent_database/persistent_database.dart';
import 'package:dashboard_manga_easy/core/services/persistent_database/src/user_preference/user_preference_entity.dart';

class Preference {
  final PersistentDatabaseSembast _persistentDatabaseSembast;

  Preference(this._persistentDatabaseSembast);

  Future<T> get<T>({required KeyPreferences keyPreferences}) async {
    final result = await _persistentDatabaseSembast.get(
      id: keyPreferences.key,
      store: StoreSembast.userPreference,
    );
    if (result == null) {
      return keyPreferences.defaultValue;
    }
    final userPreference = UserPreferenceEntity.fromJson(result);
    return userPreference.value ?? keyPreferences.defaultValue;
  }

  Future<void> put<T>({
    required T value,
    required KeyPreferences keyPreferences,
  }) async {
    await _persistentDatabaseSembast.update(
      id: keyPreferences.key,
      objeto: UserPreferenceEntity(
        value: value,
        id: keyPreferences.key,
      ).toJson(),
      store: StoreSembast.userPreference,
    );
  }

  Future<void> delete({required KeyPreferences keyPreferences}) async {
    await _persistentDatabaseSembast.delete(
      id: keyPreferences.key,
      store: StoreSembast.userPreference,
    );
  }
}
