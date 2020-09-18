import 'package:contentchef_dart/contentchef_dart.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class MockedMediaTransformations extends Mock implements MediaTransformations {}

void main() {
  group('Media class tests', () {
    test('Initialize with success', () {
      expect(Media(), const TypeMatcher<Media>());
    });

    group('rawFileUrl', () {
      final media = Media();
      final mockedPublicId = 'a public id';

      test('throw exception when publicId not provided', () {
        expect(() => media.rawFileUrl(publicId: null), throwsException);
      });

      test('return expected url', () {
        final mockedUrlResult =
            'https://res.cloudinary.com/contentchef/raw/upload/v1/a%20public%20id';
        expect(media.rawFileUrl(publicId: mockedPublicId),
            equals(mockedUrlResult));
      });
    });

    group('videoUrl', () {
      final media = Media();
      final mockedPublicId = 'a public id';

      test('throw exception when publicId not provided', () {
        expect(() => media.videoUrl(publicId: null), throwsException);
      });

      test('return expected url', () {
        final mockedUrlResult =
            'https://res.cloudinary.com/contentchef/video/upload/v1/a%20public%20id';
        expect(
            media.videoUrl(publicId: mockedPublicId), equals(mockedUrlResult));
      });
    });

    group('imageUrl', () {
      final media = Media();
      final mockedPublicId = 'a public id';

      test('throw exception when publicId not provided', () {
        expect(() => media.imageUrl(publicId: null), throwsException);
      });

      test('return expected url', () {
        final mockedUrlResult =
            'https://res.cloudinary.com/contentchef/image/upload/v1/a%20public%20id';
        expect(
            media.imageUrl(publicId: mockedPublicId), equals(mockedUrlResult));
      });
    });

    group('getUrl method tests', () {
      final mediaUtil = Media();
      final mockedMediaPublicId = 'a-test-media-publicId';
      final mockedMediaPublicIdWithSpaces = 'a publicId with spaces';

      test('to throw an exception is the publicId is not provided', () {
        expect(() => mediaUtil.getUrl(publicId: null), throwsException);
      });
      test(
          'expect to return an url without transformation if transformations are not provided',
          () {
        final mockedUrlResult =
            'https://res.cloudinary.com/contentchef/image/upload/v1/a-test-media-publicId';
        expect(mediaUtil.getUrl(publicId: mockedMediaPublicId),
            equals(mockedUrlResult));
      });
      test(
          'expect to return an url without transformation if transformations are not provided and public id with spaces',
          () {
        final mockedUrlResult =
            'https://res.cloudinary.com/contentchef/image/upload/v1/a%20publicId%20with%20spaces';
        expect(mediaUtil.getUrl(publicId: mockedMediaPublicIdWithSpaces),
            equals(mockedUrlResult));
      });
      test(
          'expect to return an url with transformations if transformations are provided',
          () {
        final mockedMediaTransformations = MockedMediaTransformations();
        final mockedUrlResult =
            'https://res.cloudinary.com/contentchef/image/upload/transformations-path-section/v1/a-test-media-publicId';
        when(mockedMediaTransformations.getStringTransformations())
            .thenReturn('transformations-path-section');
        final result = mediaUtil.getUrl(
            publicId: mockedMediaPublicId,
            transformations: mockedMediaTransformations);
        expect(result.contains('transformations-path-section'), isTrue);
        expect(result, equals(mockedUrlResult));
      });
      test(
          'expect to return an url with transformations if transformations are provided and publicId has spaces',
          () {
        final mockedMediaTransformations = MockedMediaTransformations();
        final mockedUrlResult =
            'https://res.cloudinary.com/contentchef/image/upload/transformations-path-section/v1/a%20publicId%20with%20spaces';
        when(mockedMediaTransformations.getStringTransformations())
            .thenReturn('transformations-path-section');
        final result = mediaUtil.getUrl(
            publicId: mockedMediaPublicIdWithSpaces,
            transformations: mockedMediaTransformations);
        expect(result.contains('transformations-path-section'), isTrue);
        expect(result, equals(mockedUrlResult));
      });
    });
  });
}
