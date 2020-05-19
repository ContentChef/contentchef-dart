import 'package:test/test.dart';
import 'package:contentchef_dart/src/channels.dart';
import 'package:contentchef_dart/contentchef_dart.dart';

void main() {

  group('ContentChef Client tests', () {
    final validConfiguration = Configuration(spaceId: 'test-spaceId');
    final validTargetDateResolver = TargetDateResolver(targetDateSource: null);
    test('Initializing throw exception if a null configuration is given', () {
      expect(() => ContentChef(configuration: null), throwsException);
    });

    test('Initialize successfully without a targetDateResolver', () {
      expect(ContentChef(configuration: validConfiguration), const TypeMatcher<ContentChef>());
    });

    test('Initialize successfully with a targetDateResolver', () {
      expect(ContentChef(configuration: validConfiguration, targetDateResolver: validTargetDateResolver), const TypeMatcher<ContentChef>());
    });

    test('return the configured onlineChannel', () {
      final contentChef = ContentChef(configuration: validConfiguration, targetDateResolver: validTargetDateResolver);
      expect(contentChef.getOnlineChannel(apiKey: 'test-apyKey', publishingChannel: 'test-channel'), const TypeMatcher<OnlineChannel>());
    });

    test('return the configured previewChannel', () {
      final contentChef = ContentChef(configuration: validConfiguration, targetDateResolver: validTargetDateResolver);
      expect(contentChef.getPreviewChannel(apiKey: 'test-apyKey', publishingChannel: 'test-channel', status: PublishingStatus.stage), const TypeMatcher<PreviewChannel>());
    });
  });
}
