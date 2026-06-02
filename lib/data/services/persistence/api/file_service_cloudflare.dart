import 'package:emombti/data/services/persistence/api/file_service.dart';

class FileServiceCloudFlare implements FileService {
  @override
  Future<void> deleteFile(String path) async {}

  @override
  Future<void> saveFile(String path, List<int> bytes) async {}
}
