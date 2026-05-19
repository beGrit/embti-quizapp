import 'package:http/http.dart' as http;

class HeaderInterceptorClient extends http.BaseClient {
  final http.Client _inner = http.Client();

  final Duration timeoutDuration;

  HeaderInterceptorClient({this.timeoutDuration = const Duration(seconds: 10)});

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    request.headers['X-Client-Identifier'] = 'Flutter-Mobile-App';
    request.headers['X-App-Version'] = '0.1.0';

    return _inner
        .send(request)
        .timeout(
          timeoutDuration,
          onTimeout: () {
            throw http.ClientException(
              '(Timeout after ${timeoutDuration.inSeconds}s)',
              request.url,
            );
          },
        );
  }

  @override
  void close() {
    _inner.close();
    super.close();
  }
}
