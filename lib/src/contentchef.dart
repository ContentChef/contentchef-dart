import 'package:meta/meta.dart';
import 'package:contentchef_dart/src/channels.dart';
import 'package:contentchef_dart/src/configuration.dart';
import 'package:contentchef_dart/src/request_executor.dart';
import 'package:contentchef_dart/src/requests_resources.dart';
import 'package:contentchef_dart/src/target_date_resolver.dart';

/// The ContentChef dart client sdk instance
///
/// Examples:
///
///     var client = ContentChef(configuration: Configuration(...));
///     var clientWithTargetDateResolver = ContentChef(configuration: Configuration(...), targetDateResolver: TargetDateResolver(...);
///     var onlineChannel = client.getOnlineChannel(.....);
///     var previewChannel =  clientWithTargetDateResolver.getPreviewChannel(....);
class ContentChef {
  Configuration _configuration;
  TargetDateResolver _targetDateResolver;

  /// Initializes a new 'ContentChef Client'
  ///
  /// Parameters:
  /// - configuration: Instance of Configuration
  /// - targetDateResolver: Instance of TargetDateResolver, if you plan to setup a test environment use it to retrieve contents, for examples in the future through the preview channel
  /// - Returns: an instance of `ContentChef`.
  ContentChef({ @required Configuration configuration, TargetDateResolver targetDateResolver }) {
    if (configuration == null) {
      throw Exception('the configuration cannot be null to configure ContenChef client');
    }
    _configuration = configuration;
    _targetDateResolver = targetDateResolver;
  }

  Configuration get configuration => _configuration;
  TargetDateResolver get targetDateResolver => _targetDateResolver;

  /// Create an 'OnlineChannel' instance
  ///
  /// Parameters:
  /// - apiKey: your Online apiKey, you can retrieve it from your contentChef dashboard homepage
  /// - publishingChannel: the channel id where you want to retrieve published contents
  /// - Return: an instance of `OnlineChannel`
  OnlineChannel getOnlineChannel({ @required String apiKey, @required String publishingChannel }) {
    return OnlineChannel(
      apiKey: apiKey,
      publishingChannel: publishingChannel,
      config: _configuration,
      requestExecutor: RequestExecutor(),
    );
  }

  /// Create an 'PreviewChannel' instance
  ///
  /// Parameters:
  /// - apiKey: your Preview apiKey, you can retrieve it from your contentChef dashboard homepage
  /// - status: the publishing status where you want to retrieve contents (i.e. stage or live)
  /// - publishingChannel: the channel id where you want to retrieve published contents
  /// - Return: an instance of `PreviewChannel`
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
