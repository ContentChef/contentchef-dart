import 'package:contentchef_dart/contentchef_dart.dart';
import 'package:test/test.dart';

void main() {
  group('media transformations source tests', () {
    group('MediaFormats tests', () {
      test('PNG media formats value (used to retrieve a media with png format)',
          () {
        expect(MediaFormats.PNG.toString(), equals('png'));
      });
      test('JPG media formats value (used to retrieve a media with jpg format)',
          () {
        expect(MediaFormats.JPG.toString(), equals('jpg'));
      });
      test('JP2 media formats value (used to retrieve a media with jp2 format)',
          () {
        expect(MediaFormats.JP2.toString(), equals('jp2'));
      });
      test('WPD media formats value (used to retrieve a media with wpd format)',
          () {
        expect(MediaFormats.WPD.toString(), equals('wpd'));
      });
      test(
          'WEBP media formats value (used to retrieve a media with webp format)',
          () {
        expect(MediaFormats.WEBP.toString(), equals('webp'));
      });
      test('SVG media formats value (used to retrieve a media with svg format)',
          () {
        expect(MediaFormats.SVG.toString(), equals('svg'));
      });
      test('PDF media formats value (used to retrieve a media with pdf format)',
          () {
        expect(MediaFormats.PDF.toString(), equals('pdf'));
      });
      test('GIF media formats value (used to retrieve a media with gif format)',
          () {
        expect(MediaFormats.GIF.toString(), equals('gif'));
      });
      test('ICO media formats value (used to retrieve a media with ico format)',
          () {
        expect(MediaFormats.ICO.toString(), equals('ico'));
      });
      test('TIF media formats value (used to retrieve a media with tif format)',
          () {
        expect(MediaFormats.TIF.toString(), equals('tif'));
      });
      test('BMP media formats value (used to retrieve a media with bmp format)',
          () {
        expect(MediaFormats.BMP.toString(), equals('bmp'));
      });
      test('FBX media formats value (used to retrieve a media with fbx format)',
          () {
        expect(MediaFormats.FBX.toString(), equals('fbx'));
      });
      test('ARW media formats value (used to retrieve a media with arw format)',
          () {
        expect(MediaFormats.ARW.toString(), equals('arw'));
      });
    });

    group('MediaTransformations class tests', () {
      test('to init with success without params', () {
        expect(
            MediaTransformations(), const TypeMatcher<MediaTransformations>());
      });
      test('to init with success with params', () {
        expect(
            MediaTransformations(
                mediaHeight: 100,
                mediaWidth: 100,
                autoFormat: true,
                mediaFormat: MediaFormats.PNG),
            const TypeMatcher<MediaTransformations>());
      });

      group('getTransformations tests', () {
        test('return an empty string if no transformations are provided', () {
          final mediaTransformations = MediaTransformations();
          expect(
              mediaTransformations.getStringTransformations().isEmpty, isTrue);
        });
        test('return only height transformation', () {
          final mediaTransformations = MediaTransformations(mediaHeight: 100);
          final stringTransformations =
              mediaTransformations.getStringTransformations();
          expect(stringTransformations.isEmpty, isFalse);
          expect(stringTransformations.contains('h_100'), isTrue);
        });
        test('return only width transformation', () {
          final mediaTransformations = MediaTransformations(mediaWidth: 100);
          final stringTransformations =
              mediaTransformations.getStringTransformations();
          expect(stringTransformations.isEmpty, isFalse);
          expect(stringTransformations.contains('w_100'), isTrue);
        });
        test('return only autoFormat transformation', () {
          final mediaTransformations = MediaTransformations(autoFormat: true);
          final stringTransformations =
              mediaTransformations.getStringTransformations();
          expect(stringTransformations.isEmpty, isFalse);
          expect(stringTransformations.contains('f_auto'), isTrue);
        });
        test('return only the specified mediaFormat transformation', () {
          final mediaTransformations =
              MediaTransformations(mediaFormat: MediaFormats.JPG);
          final stringTransformations =
              mediaTransformations.getStringTransformations();
          expect(stringTransformations.isEmpty, isFalse);
          expect(stringTransformations.contains('f_jpg'), isTrue);
        });
        test(
            'if autoFormat is set to true and mediaFormat is provided only format auto will return as transformation',
            () {
          final mediaTransformations = MediaTransformations(
              autoFormat: true, mediaFormat: MediaFormats.JPG);
          final stringTransformations =
              mediaTransformations.getStringTransformations();
          expect(stringTransformations.isEmpty, isFalse);
          expect(stringTransformations.contains('f_auto'), isTrue);
          expect(stringTransformations.contains('f_jpg'), isFalse);
        });
        test(
            'if autoFormat is set to false and mediaFormat is provided only mediaFormat will return as transformation',
            () {
          final mediaTransformations = MediaTransformations(
              autoFormat: false, mediaFormat: MediaFormats.JPG);
          final stringTransformations =
              mediaTransformations.getStringTransformations();
          expect(stringTransformations.isEmpty, isFalse);
          expect(stringTransformations.contains('f_auto'), isFalse);
          expect(stringTransformations.contains('f_jpg'), isTrue);
        });
        test('return all transformation provided with autoFormat', () {
          final mediaTransformations = MediaTransformations(
              autoFormat: true, mediaHeight: 100, mediaWidth: 100);
          final stringTransformations =
              mediaTransformations.getStringTransformations();
          expect(stringTransformations.isEmpty, isFalse);
          expect(stringTransformations.contains('f_auto'), isTrue);
          expect(stringTransformations.contains('w_100'), isTrue);
          expect(stringTransformations.contains('h_100'), isTrue);
        });
        test('return all transformation provided with mediaFormat', () {
          final mediaTransformations = MediaTransformations(
              mediaFormat: MediaFormats.JPG, mediaHeight: 100, mediaWidth: 100);
          final stringTransformations =
              mediaTransformations.getStringTransformations();
          expect(stringTransformations.isEmpty, isFalse);
          expect(stringTransformations.contains('f_jpg'), isTrue);
          expect(stringTransformations.contains('w_100'), isTrue);
          expect(stringTransformations.contains('h_100'), isTrue);
        });
      });
    });

    group('VideoTransformations', () {
      test('return string with quality and croppingMode set', () {
        final transformations = VideoTransformations(
                autoFormat: true,
                croppingMode: CroppingMode.scale,
                videoQuality: 30)
            .getStringTransformations();
        expect(transformations.contains('q_30'), isTrue);
        expect(transformations.contains('c_scale'), isTrue);
      });

      test('return string quality set to auto', () {
        final transformations =
            VideoTransformations().getStringTransformations();
        print(transformations);
        expect(transformations.contains('q_auto'), isTrue);
      });
    });
  });
}
