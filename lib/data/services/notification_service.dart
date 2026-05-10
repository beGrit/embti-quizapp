abstract class NotificationService {
  Future<void> init();
  Future<void> requestPermissions();
  Future<void> showNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
  });
  void startTestCron();
}
