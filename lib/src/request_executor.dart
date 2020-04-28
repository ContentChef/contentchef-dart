import 'dart:async';
import 'dart:convert';
import 'package:contentchef_dart/src/configuration.dart';
import 'package:contentchef_dart/src/requests_filters.dart';
import 'package:contentchef_dart/src/responses.dart';
import 'package:meta/meta.dart';

/// ContentChef RequestExecutor class (internal use only)
class RequestExecutor {

  /// Resolve all api requests
  ///
  /// Parameters:
  /// - path: the request path
  /// - apiKey: the space apiKey
  /// - config: Configuration instance
  /// - filters: a map of filters used as queryParameters in the api request
  /// - Returns:
  ///   Success => returns the api response body as Json object if the response statusCode is >= 200 or < 299.
  ///   Fail =>    returns an exception if the response statusCode is < 200 or > 299;
  Future<Map<String, dynamic>> _executeRequest({
    @required String path,
    @required String apiKey,
    @required Configuration config,
    @required Map<String, String> filters,
  }) async {
    var uri = Uri.https(config.host, path, filters);
    var response = (await config.httpClient.get(uri, headers: {
      'X-SPACE-D-API-Key': apiKey,
    }).timeout(Duration(milliseconds: config.timeout)));
    config.httpClient.close();

    if (response.statusCode >= 200 && response.statusCode <= 299) {
      return jsonDecode(response.body);
    }
    print(response);
    throw Exception('request failed with status code: ${response.statusCode}');
  }

  /// Resolve the getContent api request
  ///
  /// Parameters:
  /// - path: the request path
  /// - apiKey: the space apiKey
  /// - config: Configuration instance
  /// - filters: a map of filters used as queryParameters in the api request
  /// - Returns:
  ///     Success => returns an instance of ContentResponse<T> with payload(T) attribute of the defined type.
  ///     Fail =>    returns an exception if the response statusCode is < 200 or > 299 or the mapping to ContentResponse<T> failed;
  Future<ContentResponse<T>> executeGetContentRequest<T>({
    @required String path,
    @required String apiKey,
    @required Configuration config,
    @required GetContentFilters filters,
  }) async {
    try {
      var requestBodyResult = await _executeRequest(path: path, apiKey: apiKey, config: config, filters: filters.toQueryParametersMap());
      return ContentResponse<T>(requestBodyResult);
    } catch (e) {
      rethrow;
    }
  }

  /// Resolve the searchContents api request
  ///
  /// Parameters:
  /// - path: the request path
  /// - apiKey: the space apiKey
  /// - config: Configuration instance
  /// - filters: a map of filters used as queryParameters in the api request
  /// - Returns:
  ///     Success => returns an instance of PaginatedResponse<T> with items(ContentResponse<T>) attribute of the defined type.
  ///     Fail =>    returns an exception if the response statusCode is < 200 or > 299 or the mapping to PaginatedResponse<T> failed;
  Future<PaginatedResponse<T>> executeSearchContentsRequest<T>({
    @required String path,
    @required String apiKey,
    @required Configuration config,
    @required SearchContentsFilters filters,
  }) async {
    try {
      var requestBodyResult = await _executeRequest(path: path, apiKey: apiKey, config: config, filters: filters.toQueryParametersMap());
      return PaginatedResponse<T>(requestBodyResult);
    } catch (e) {
      rethrow;
    }
  }
}
