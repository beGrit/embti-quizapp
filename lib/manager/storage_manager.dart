import 'package:cloudflare_r2/cloudflare_r2.dart';
import 'package:emombti/app_state/auth.dart';
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
import 'package:flutter_dotenv/flutter_dotenv.dart';

class StorageManager extends ChangeNotifier {
  final AuthState authState;
  String? baseDir;
  InitializationStatus status = InitializationStatus.initial;
  Object? error;

  late final LocaKeyValueStorage localKeyValueStorage;
  late final LocalStorage localStorage;
  late final FileServiceCloudFlare fileServiceCloudFlare;
  late final FirestoreService firestoreService;
  late final PocketBaseService pocketBaseService;

  StorageManager({required this.authState}) {
    authState.addListener(_onAuthStateChanged);
  }

  @override
  void dispose() {
    authState.removeListener(_onAuthStateChanged);
    super.dispose();
  }

  void _onAuthStateChanged() {
    if (status == InitializationStatus.success) {
      localStorage.switchUser(authState.userId);
    }
  }

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
      CloudFlareR2.init(
        accountId: dotenv.get('R2_ACCOUNT_ID'),
        accessKeyId: dotenv.get('R2_ACCESS_KEY_ID'),
        secretAccessKey: dotenv.get('R2_SECRET_ACCESS_KEY'),
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
