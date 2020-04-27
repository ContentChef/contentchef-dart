import 'dart:async';
import 'dart:convert';
import 'package:contentchef_dart/src/configuration.dart';
import 'package:contentchef_dart/src/requests_filters.dart';
import 'package:contentchef_dart/src/responses.dart';
import 'package:meta/meta.dart';

class RequestExecutor {
  Future<Map<String, dynamic>> _executeRequest({
    @required String path,
    @required String apiKey,
    @required Configuration config,
    @required Map<String, String> filters,
  }) async {
    var uri = Uri.https(config.host, '/dev$path', filters);
    var response = (await config.httpClient.get(uri, headers: {
      'X-SPACE-D-API-Key': apiKey,
    }).timeout(Duration(milliseconds: config.timeout)));
    config.httpClient.close();

    if (response.statusCode >= 200 && response.statusCode <= 299) {
      return jsonDecode(response.body);
    }
    throw Exception('request failed with status code: ${response.statusCode}');
  }

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
