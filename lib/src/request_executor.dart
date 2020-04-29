import 'dart:async';
import 'dart:convert';
import 'package:contentchef_dart/src/configuration.dart';
import 'package:contentchef_dart/src/errors.dart';
import 'package:contentchef_dart/src/requests_filters.dart';
import 'package:contentchef_dart/src/responses.dart';
import 'package:meta/meta.dart';

/// ContentChef RequestExecutor class (internal use only)
///
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
  ///   Fail =>    returns a BadRequestException if the response statusCode is equal to 400;
  ///              returns a ForbiddenException if the response statusCode is equal to 403;
  ///              returns a NotFoundException if the response statusCode is equal to 404;
  ///              returns a GenericErrorException otherwise
  ///
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

    if (response.statusCode == 400) {
      throw BadRequestException(
          code: response.statusCode, error: jsonDecode(response.body));
    }

    if (response.statusCode == 403) {
      throw ForbiddenException(code: response.statusCode);
    }

    if (response.statusCode == 404) {
      throw NotFoundException(code: response.statusCode);
    }

    throw GenericErrorException(code: response.statusCode);
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
  ///     Fail =>    returns a BadRequestException if the response statusCode is equal to 400;
  ///                returns a ForbiddenException if the response statusCode is equal to 403;
  ///                returns a NotFoundException if the response statusCode is equal to 404;
  ///                returns a GenericErrorException otherwise
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
  ///     Fail =>    returns a BadRequestException if the response statusCode is equal to 400;
  ///                returns a ForbiddenException if the response statusCode is equal to 403;
  ///                returns a NotFoundException if the response statusCode is equal to 404;
  ///                returns a GenericErrorException otherwise
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
