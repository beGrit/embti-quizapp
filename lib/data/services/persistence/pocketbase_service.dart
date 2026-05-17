import 'package:pocketbase/pocketbase.dart';

import 'remote_file_service.dart';

class PocketBaseService implements RemoteFileService {
  final PocketBase client;

  PocketBaseService({String baseUrl = 'http://192.168.0.102:8090/'})
    : client = PocketBase(baseUrl);

  /// Get the full URL for a file stored in PocketBase
  @override
  Uri getFileUrl(
    String? recordId,
    String? collectionId,
    String? collectionName,
    String? filename,
  ) {
    if (filename == null || filename.isEmpty) return Uri();
    return client.files.getURL(
      RecordModel({
        'id': recordId ?? '',
        'collectionId': collectionId,
        'collectionName': collectionName,
      }),
      filename,
    );
  }
}
