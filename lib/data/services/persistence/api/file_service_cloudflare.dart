import 'package:cloudflare_r2/cloudflare_r2.dart';
import 'package:emombti/data/services/persistence/api/file_service.dart';

class FileServiceCloudFlare implements FileService {
  final String domain = 'embti-storage-dev.grit-soft.com';
  final String bucket = 'com-grit-soft-app-embti-dev';

  @override
  Future<void> deleteFile(String path) async {}

  @override
  Future<void> saveFile(
    String objectName,
    List<int> objectBytes,
    String? displayName,
  ) async {
    try {
      await CloudFlareR2.putObject(
        bucket: bucket,
        objectName: objectName,
        objectBytes: objectBytes,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Uri getUri(String objectName) {
    return Uri.parse('https://$domain/$objectName');
  }
}
