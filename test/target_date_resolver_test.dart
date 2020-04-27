import 'package:test/test.dart';
import 'package:contentchef_dart/src/target_date_resolver.dart';

void main() {
  group('target date resolver class tests', () {

    group('target date resolver initilizing tests', () {
      test('target date source as string', () {
        expect(TargetDateResolver(targetDateSource: 'string-source').runtimeType, TargetDateResolver);
      });
      test('target date source as null', () {
        expect(TargetDateResolver().runtimeType, TargetDateResolver);
      });
      test('target date source as TargetDateDef', () {
        expect(TargetDateResolver(targetDateSource: () async => 'test').runtimeType, TargetDateResolver);
      });
      test('invalid target date source', () {
        expect(() => TargetDateResolver(targetDateSource: 10), throwsException);
        expect(() => TargetDateResolver(targetDateSource: 10.15), throwsException);
        expect(() => TargetDateResolver(targetDateSource: false), throwsException);
        expect(() => TargetDateResolver(targetDateSource: () => true), throwsException);
        expect(() => TargetDateResolver(targetDateSource: () async => 10), throwsException);
      });
    });

    group('target date result', () {
      final mockedDate = DateTime(2020).toIso8601String();

      test('return the given string', () async {
        final targetDateResolver = TargetDateResolver(targetDateSource: mockedDate);
        expect(await targetDateResolver.targetDate(), equals(mockedDate));
      });
      test('return the value of the given TargetDateDef when it is a string', () async {
        final targetDateResolver = TargetDateResolver(targetDateSource: () async => mockedDate);
        expect(await targetDateResolver.targetDate(), equals(mockedDate));
      });
      test('return the value of the given TagetDateDef when it is null', () async {
        final targetDateResolver = TargetDateResolver(targetDateSource: () async => null);
        expect(await targetDateResolver.targetDate(), isNull);
      });
    });
  });
}
