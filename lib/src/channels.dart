import 'dart:async';
import 'package:meta/meta.dart';
import 'package:contentchef_dart/src/urls.dart';
import 'package:contentchef_dart/src/requests_filters.dart';
import 'package:contentchef_dart/src/responses.dart';
import 'package:contentchef_dart/src/configuration.dart';
import 'package:contentchef_dart/src/request_executor.dart';
import 'package:contentchef_dart/src/requests_resources.dart';
import 'package:contentchef_dart/src/target_date_resolver.dart';

class OnlineChannel {
  String _apiKey;
  String _publishingChannel;
  RequestExecutor _requestExecutor;
  Configuration _config;

  OnlineChannel({
    @required String apiKey,
    @required Configuration config,
    @required String publishingChannel,
    @required RequestExecutor requestExecutor
  }) {
    if (apiKey == null) {
      throw Exception('the online apiKey cannot be null to configure the online channel');
    }
    if (publishingChannel == null) {
      throw Exception('the publishing channel cannot be null to configure the online channel');
    }
    if (requestExecutor == null) {
      throw Exception('a request executor must be defined to configure the preview channel');
    }
    _apiKey = apiKey;
    _publishingChannel = publishingChannel;
    _config = config;
    _requestExecutor = requestExecutor;
  }

  Future<ContentResponse<T>> getContent<T>({
    @required GetContentFilters filters
  }) async {
    var onlineContentPath = getOnlinePath(spaceId: _config.spaceId, requestType: RequestTypes.content, channel: _publishingChannel);
    var result = await _requestExecutor.executeGetContentRequest<T>(path: onlineContentPath, apiKey: _apiKey, config: _config, filters: filters);
    return result;
  }

  Future<PaginatedResponse<T>> searchContents<T>({
    @required SearchContentsFilters filters
  }) async {
    var onlineSearchPath = getOnlinePath(spaceId: _config.spaceId, requestType: RequestTypes.search, channel: _publishingChannel);
    return await _requestExecutor.executeSearchContentsRequest<T>(path: onlineSearchPath, apiKey: _apiKey, config: _config, filters: filters);
  }
}

class PreviewChannel extends RequestExecutor {
  String _apiKey;
  String _publishingChannel;
  TargetDateResolver _targetDateResolver;
  PublishingStatus _status;
  Configuration _config;
  RequestExecutor _requestExecutor;

  PreviewChannel({
    @required String apiKey,
    @required PublishingStatus status,
    @required Configuration config,
    @required String publishingChannel,
    @required RequestExecutor requestExecutor,
    TargetDateResolver targetDateResolver
  }) {
    if (apiKey == null) {
      throw Exception('a preview apiKey must be defined to configure the preview channel');
    }
    if (status == null) {
      throw Exception('a status must be defined to configure the preview channel');
    }
    if (publishingChannel == null) {
      throw Exception('a publishing channel must be defined to configure the preview channel');
    }
    if (requestExecutor == null) {
      throw Exception('a request executor must be defined to configure the preview channel');
    }
    _apiKey = apiKey;
    _status = status;
    _config = config;
    _publishingChannel = publishingChannel;
    _targetDateResolver = targetDateResolver;
    _requestExecutor = requestExecutor;
  }

  Future<ContentResponse<T>> getContent<T>({
    @required GetContentFilters filters,
  }) async {
    var previewContentPath = getPreviewPath(spaceId: _config.spaceId, requestType: RequestTypes.content, status: _status, channel: _publishingChannel);
    var getContentFilters = filters.toQueryParametersMap();
    var targetDate = _targetDateResolver != null ? await _targetDateResolver.targetDate() : null;
    if (targetDate != null) {
      getContentFilters['targetDate'] = targetDate;
    }
    return await _requestExecutor.executeGetContentRequest<T>(path: previewContentPath, apiKey: _apiKey, config: _config, filters: filters);
  }

  Future<PaginatedResponse<T>> searchContents<T>({
    @required SearchContentsFilters filters,
  }) async {
    var previewSearchPath = getPreviewPath(spaceId: _config.spaceId, requestType: RequestTypes.search, status: _status, channel: _publishingChannel);
    var searchContentsFilters = filters.toQueryParametersMap();
    var targetDate = _targetDateResolver != null ? await _targetDateResolver.targetDate() : null;
    if (targetDate != null) {
      searchContentsFilters['targetDate'] = targetDate;
    }
    return await _requestExecutor.executeSearchContentsRequest(path: previewSearchPath, apiKey: _apiKey, config: _config, filters: filters);
  }
}
