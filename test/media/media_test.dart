import 'package:contentchef_dart/contentchef_dart.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class MockedMediaTransformations extends Mock implements MediaTransformations {}

void main() {
  group('Media class tests', () {
    test('Initialize with success', () {
      expect(Media(), const TypeMatcher<Media>());
    });

    group('getUrl method tests', () {
      final mediaUtil = Media();
      final mockedMediaPublicId = 'a-test-media-publicId';

      test('to throw an exception is the publicId is not provided', () {
        expect(() => mediaUtil.getUrl(publicId: null), throwsException);
      });
      test('expect to return an url without transnformation if transformations are not provided', () {
        final mockedUrlResult = 'https://res.cloudinary.com/contentchef/image/upload/v1/a-test-media-publicId';
        expect(mediaUtil.getUrl(publicId: mockedMediaPublicId), equals(mockedUrlResult));
      });
      test('expect to return an url with transformations if transformations are provided', () {
        final mockedMediaTransformations = MockedMediaTransformations();
        final mockedUrlResult = 'https://res.cloudinary.com/contentchef/image/upload/transformations-path-section/v1/a-test-media-publicId';
        when(mockedMediaTransformations.getStringTransformations()).thenReturn('transformations-path-section');
        final result = mediaUtil.getUrl(publicId: mockedMediaPublicId, transformations: mockedMediaTransformations);
        expect(result.contains('transformations-path-section'), isTrue);
        expect(result, equals(mockedUrlResult));
      });
    });
  });
}
