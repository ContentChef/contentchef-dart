import 'package:meta/meta.dart';
import 'package:contentchef_dart/src/channels.dart';
import 'package:contentchef_dart/src/configuration.dart';
import 'package:contentchef_dart/src/request_executor.dart';
import 'package:contentchef_dart/src/requests_resources.dart';
import 'package:contentchef_dart/src/target_date_resolver.dart';

/// ContentChef dart client sdk
class ContentChef {
  Configuration _configuration;
  TargetDateResolver _targetDateResolver;

  ContentChef({ @required Configuration configuration, TargetDateResolver targetDateResolver }) {
    if (configuration == null) {
      throw Exception('the configuration cannot be null to configure ContenChef client');
    }
    _configuration = configuration;
    _targetDateResolver = targetDateResolver;
  }

  Configuration get configuration => _configuration;
  TargetDateResolver get targetDateResolver => _targetDateResolver;

  OnlineChannel getOnlineChannel({ @required String apiKey, @required String publishingChannel }) {
    return OnlineChannel(
      apiKey: apiKey,
      publishingChannel: publishingChannel,
      config: _configuration,
      requestExecutor: RequestExecutor(),
    );
  }

  PreviewChannel getPreviewChannel({ @required String apiKey, @required PublishingStatus status, @required String publishingChannel }) {
    return PreviewChannel(
      apiKey: apiKey,
      status: status,
      publishingChannel: publishingChannel,
      config: _configuration,
      targetDateResolver: _targetDateResolver,
      requestExecutor: RequestExecutor(),
    );
  }
}
