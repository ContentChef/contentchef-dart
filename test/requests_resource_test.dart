import 'package:test/test.dart';
import 'package:contentchef_dart/src/requests_resources.dart';

void main() {
  group('Request Resources tests', () {
    group('RequestTypes tests', () {
      test('Request type content', () {
        expect(RequestTypes.content.toString(), equals('content'));
      });
      test('Request type search', () {
        expect(RequestTypes.search.toString(), equals('search/v2'));
      });
    });

    group('PublishingStatus tests', () {
      test('Publishing status stage', () {
        expect(PublishingStatus.stage.toString(), equals('staging'));
      });
      test('Publishing status live', () {
        expect(PublishingStatus.live.toString(), equals('live'));
      });
    });
  });
}
