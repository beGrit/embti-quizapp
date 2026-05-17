abstract class RemoteFileService {
  /// Get the full URL for a remote file
  Uri getFileUrl(
    String? recordId,
    String? collectionId,
    String? collectionName,
    String? filename,
  );
}
