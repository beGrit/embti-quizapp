import 'package:emombti/data/services/persistence/api/file_service_cloudflare.dart';
import 'package:emombti/data/services/persistence/api/firestore_service.dart';
import 'package:emombti/data/services/persistence/api/pocketbase_service.dart';
import 'package:emombti/data/services/persistence/local/local_keyvalue_storage.dart';
import 'package:emombti/data/services/persistence/local/local_keyvalue_storage_sharedpreferences.dart';
import 'package:emombti/data/services/persistence/local/local_storage.dart';
import 'package:emombti/data/services/persistence/local/local_storage_facade.dart';
import 'package:emombti/data/services/persistence/local/local_storage_file.dart';
import 'package:emombti/data/services/persistence/local/local_storage_sqlite.dart';
import 'package:emombti/domain/constants/status.dart';
import 'package:flutter/foundation.dart';

class StorageManager extends ChangeNotifier {
  String? baseDir;
  InitializationStatus status = InitializationStatus.initial;
  Object? error;

  late final LocaKeyValueStorage localKeyValueStorage;
  late final LocalStorage localStorage;
  late final FileServiceCloudFlare fileServiceCloudFlare;
  late final FirestoreService firestoreService;
  late final PocketBaseService pocketBaseService;

  Future<void> buildStorage() async {
    status = InitializationStatus.loading;
    notifyListeners();
    try {
      localKeyValueStorage = SharedPreferencesService();
      fileServiceCloudFlare = FileServiceCloudFlare();
      firestoreService = FirestoreService();
      pocketBaseService = PocketBaseService();
      localStorage = LocalStorageFacade(
        sqlite: LocalStorageSqlite(),
        file: LocalStorageFile(),
      );
      status = InitializationStatus.success;
    } catch (e) {
      status = InitializationStatus.failure;
      error = e;
    } finally {
      notifyListeners();
    }
    notifyListeners();
  }
}
