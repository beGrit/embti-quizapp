import 'package:emombti/utils/http_util.dart';
import 'package:pocketbase/pocketbase.dart';

class PocketBaseService {
  final PocketBase client;

  PocketBaseService({String baseUrl = 'http://192.168.0.102:8090/'})
    : client = PocketBase(
        baseUrl,
        httpClientFactory: () => HeaderInterceptorClient(),
      );

  void dispose() {
    client.close();
  }
}
