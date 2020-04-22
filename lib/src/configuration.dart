import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

const String _defaultHost = 'api.contentchef.io';
const int _defaultTimeout = 5000;

class Configuration {
  String _spaceId;
  String _host = _defaultHost;
  int _timeout = _defaultTimeout;
  http.Client _httpClient;

  Configuration({
    @required String spaceId,
    String host = _defaultHost,
    int timeout = _defaultTimeout,
    http.Client client
  }) {
    if (spaceId == null) {
      throw Exception('the spaceId cannot be null to create a ContentChef client configuration');
    }
    _spaceId = spaceId;
    _host = host;
    _timeout = timeout;
    if (client != null && client is http.Client) {
      _httpClient = client;
    } else {
      _httpClient = http.Client();
    }
  }

  String get host => _host;
  String get spaceId => _spaceId;
  int get timeout => _timeout;
  http.Client get httpClient => _httpClient;
}
