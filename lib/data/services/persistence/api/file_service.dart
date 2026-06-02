abstract class FileService {
  Future<void> saveFile(String path, List<int> bytes);

  Future<void> deleteFile(String path);
}
