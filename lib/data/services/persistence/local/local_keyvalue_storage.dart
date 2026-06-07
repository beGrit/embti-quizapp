import 'package:emombti/utils/result.dart';

abstract class LocaKeyValueStorage {
  Future<Result<String?>> fetch(String key);
  Future<Result<void>> save(String key, String? value);
}
