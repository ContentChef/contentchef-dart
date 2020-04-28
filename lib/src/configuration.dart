import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

/// ContentChef default api host
const String _defaultHost = 'api.contentchef.io';

/// ContentChef default api request timeout
const int _defaultTimeout = 5000;

/// A ContentChef Configuration class used to configure ContentChefClient
///
/// Examples:
///
///     var baseConfiguration = Configuration(spaceId: 'your-spaceId');
///     var fullConfiguration = Configuration(spaceId: 'your-spaceId', host: 'custom-ContentChef-host', timeout: 10000, client: yourCustomHttpClient);
class Configuration {
  String _spaceId;
  String _host = _defaultHost;
  int _timeout = _defaultTimeout;
  http.Client _httpClient;


  /// Initializes a new `ContentChef configuration` needed to initialize ContentChef Client.
  ///
  /// Parameters:
  /// - spaceId: ContentChef spaceId
  /// - host: a default host is configured, if you have an enterprise plan you could have a custom api domain
  /// - timeout: a default timeout is configured (5000 ms), if you need an higher timeout configure it
  /// - client: a default httpClient is configure, to use a custom httpClient configure it
  /// - Returns: an instance of `Configuration`.
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
