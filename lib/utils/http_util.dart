import 'package:http/http.dart' as http;

class HeaderInterceptorClient extends http.BaseClient {
  final http.Client _inner = http.Client();

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    request.headers['X-Client-Identifier'] = 'Flutter-Mobile-App';
    request.headers['X-App-Version'] = '0.1.0';

    return _inner.send(request);
  }

  @override
  void close() {
    _inner.close();
    super.close();
  }
}
