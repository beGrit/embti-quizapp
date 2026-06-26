abstract class FileService {
  Future<void> saveFile(
    String objectName,
    List<int> objectBytes,
    String? displayName,
  );

  Future<void> deleteFile(String path);

  Uri getUri(String objectName);
}
