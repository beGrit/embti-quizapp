import 'package:emombti/utils/http_util.dart';
import 'package:pocketbase/pocketbase.dart';

class PocketBaseService {
  final PocketBase client;

  PocketBaseService({String baseUrl = 'https://grit-soft.cn/pocketbase'})
    : client = PocketBase(
        baseUrl,
        httpClientFactory: () => HeaderInterceptorClient(),
      );

  void dispose() {
    client.close();
  }
}
