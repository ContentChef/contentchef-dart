import 'dart:async';
import 'package:meta/meta.dart';
import 'package:contentchef_dart/src/urls.dart';
import 'package:contentchef_dart/src/requests_filters.dart';
import 'package:contentchef_dart/src/responses.dart';
import 'package:contentchef_dart/src/configuration.dart';
import 'package:contentchef_dart/src/request_executor.dart';
import 'package:contentchef_dart/src/requests_resources.dart';
import 'package:contentchef_dart/src/target_date_resolver.dart';

/// ContentChef OnlineChannel class used to retrieve contents in live status
///
class OnlineChannel {
  String _apiKey;
  String _publishingChannel;
  RequestExecutor _requestExecutor;
  Configuration _config;

  /// Create a `OnlineChannel` instance.
  ///
  /// Parameters:
  /// - apiKey: ContentChef online apiKey
  /// - config: Configuration instance
  /// - publishingChannel: the channel id where you want to retrieve published contents
  /// - requestExecutor: RequestExecutor instance
  /// - Returns: an instance of `OnlineChannel`.
  ///
  OnlineChannel(
      {@required String apiKey,
      @required Configuration config,
      @required String publishingChannel,
      @required RequestExecutor requestExecutor}) {
    if (apiKey == null) {
      throw Exception(
          'the online apiKey cannot be null to configure the online channel');
    }
    if (publishingChannel == null) {
      throw Exception(
          'the publishing channel cannot be null to configure the online channel');
    }
    if (requestExecutor == null) {
      throw Exception(
          'a request executor must be defined to configure the preview channel');
    }
    _apiKey = apiKey;
    _publishingChannel = publishingChannel;
    _config = config;
    _requestExecutor = requestExecutor;
  }

  /// Retrieves a content by the parameters specified in `GetContentFilters`.
  ///
  /// - Parameters:
  /// - filters: GetContentFilters instance
  /// - fromJson: FromJsonDef<T> function (used to serialize payload attribute as instance of T)
  /// - Returns:
  ///     Success => returns an instance of ContentResponse<T> with payload(T) attribute of the defined type.
  ///     Fail =>    returns an exception if the response statusCode is < 200 or > 299 or the mapping to ContentResponse<T> failed;
  ///
  Future<ContentResponse<T>> getContent<T>({
    @required GetContentFilters filters,
    @required FromJsonDef<T> fromJson,
  })async {
    if (fromJson == null) {
      throw Exception('to correctly retrieve a content a fromJson function cannot be null');
    }
    var onlineContentPath = getOnlinePath(
        spaceId: _config.spaceId,
        requestType: RequestTypes.content,
        channel: _publishingChannel);
    var result = await _requestExecutor.executeGetContentRequest<T>(
      path: onlineContentPath,
      apiKey: _apiKey,
      config: _config,
      filters: filters,
      fromJson: fromJson,
    );
    return result;
  }

  /// Retrieves contents by the parameters specified in `SearchContentFilters`.
  ///
  /// - Parameters:
  /// - filters: SearchContentFilters instance
  /// - fromJson: FromJsonDef<T> function (used to serialize the items payload attribute as instance of T)
  /// - Returns:
  ///     Success => returns an instance of PaginatedResponse<T> with items (ContentResponse<T>) attribute of the defined type.
  ///     Fail =>    returns an exception if the response statusCode is < 200 or > 299 or the mapping to PaginatedResponse<T> failed;
  ///
  Future<PaginatedResponse<T>> searchContents<T>({
    @required SearchContentsFilters filters,
    @required FromJsonDef<T> fromJson,
  }) async {
    if (fromJson == null) {
      throw Exception('to correctly retrieve contents a fromJson function cannot be null');
    }
    var onlineSearchPath = getOnlinePath(
      spaceId: _config.spaceId,
      requestType: RequestTypes.search,
      channel: _publishingChannel);
    return await _requestExecutor.executeSearchContentsRequest<T>(
      path: onlineSearchPath,
      apiKey: _apiKey,
      config: _config,
      filters: filters,
      fromJson: fromJson,
    );
  }
}

/// ContentChef PreviewChannel class used to retrieve contents in live or staging status
///
class PreviewChannel extends RequestExecutor {
  String _apiKey;
  String _publishingChannel;
  TargetDateResolver _targetDateResolver;
  PublishingStatus _status;
  Configuration _config;
  RequestExecutor _requestExecutor;

  /// Create a `PreviewChannel` instance.
  ///
  /// Parameters:
  /// - apiKey: ContentChef preview apiKey
  /// - status: the publishing status where you want to retrieve contents (i.e. staging or live)
  /// - config: Configuration instance
  /// - publishingChannel: the channel id where you want to retrieve published contents
  /// - requestExecutor: RequestExecutor instance
  /// - Returns: an instance of `PreviewChannel`.
  ///
  PreviewChannel(
      {@required String apiKey,
      @required PublishingStatus status,
      @required Configuration config,
      @required String publishingChannel,
      @required RequestExecutor requestExecutor,
      TargetDateResolver targetDateResolver}) {
    if (apiKey == null) {
      throw Exception(
          'a preview apiKey must be defined to configure the preview channel');
    }
    if (status == null) {
      throw Exception(
          'a status must be defined to configure the preview channel');
    }
    if (publishingChannel == null) {
      throw Exception(
          'a publishing channel must be defined to configure the preview channel');
    }
    if (requestExecutor == null) {
      throw Exception(
          'a request executor must be defined to configure the preview channel');
    }
    _apiKey = apiKey;
    _status = status;
    _config = config;
    _publishingChannel = publishingChannel;
    _targetDateResolver = targetDateResolver;
    _requestExecutor = requestExecutor;
  }

  /// Retrieves a content by the parameters specified in `GetContentFilters`.
  ///
  /// - Parameters:
  /// - filters: GetContentFilters instance
  /// - fromJson: FromJsonDef<T> function (used to serialize payload attribute as instance of T)
  /// - Returns:
  ///     Success => returns an instance of ContentResponse<T> with payload(T) attribute of the defined type.
  ///     Fail =>    returns an exception if the response statusCode is < 200 or > 299 or the mapping to ContentResponse<T> failed;
  ///
  Future<ContentResponse<T>> getContent<T>({
    @required GetContentFilters filters,
    @required FromJsonDef<T> fromJson,
  }) async {
    if (fromJson == null) {
      throw Exception('to correctly retrieve a content a fromJson function cannot be null');
    }
    var previewContentPath = getPreviewPath(
        spaceId: _config.spaceId,
        requestType: RequestTypes.content,
        status: _status,
        channel: _publishingChannel);
    var getContentFilters = filters.toQueryParametersMap();
    var targetDate = _targetDateResolver != null
        ? await _targetDateResolver.targetDate()
        : null;
    if (targetDate != null) {
      getContentFilters['targetDate'] = targetDate;
    }
    return await _requestExecutor.executeGetContentRequest<T>(
        fromJson: fromJson,
        path: previewContentPath,
        apiKey: _apiKey,
        config: _config,
        filters: filters);
  }

  /// Retrieves contents by the parameters specified in `SearchContentFilters`.
  ///
  /// - Parameters:
  /// - filters: SearchContentFilters instance
  /// - fromJson: FromJsonDef<T> function (used to serialize the items payload attribute as instance of T)
  /// - Returns:
  ///     Success => returns an instance of PaginatedResponse<T> with items (ContentResponse<T>) attribute of the defined type.
  ///     Fail =>    returns an exception if the response statusCode is < 200 or > 299 or the mapping to PaginatedResponse<T> failed;
  ///
  Future<PaginatedResponse<T>> searchContents<T>({
    @required SearchContentsFilters filters,
    @required FromJsonDef<T> fromJson,
  }) async {
    if (fromJson == null) {
      throw Exception('to correctly retrieve contents a fromJson function cannot be null');
    }
    var previewSearchPath = getPreviewPath(
        spaceId: _config.spaceId,
        requestType: RequestTypes.search,
        status: _status,
        channel: _publishingChannel);
    var searchContentsFilters = filters.toQueryParametersMap();
    var targetDate = _targetDateResolver != null
        ? await _targetDateResolver.targetDate()
        : null;
    if (targetDate != null) {
      searchContentsFilters['targetDate'] = targetDate;
    }
    return await _requestExecutor.executeSearchContentsRequest<T>(
        fromJson: fromJson,
        path: previewSearchPath,
        apiKey: _apiKey,
        config: _config,
        filters: filters);
  }
}
