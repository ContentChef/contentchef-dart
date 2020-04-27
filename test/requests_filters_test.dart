import 'dart:convert';
import 'package:contentchef_dart/src/requests_filters.dart';
import 'package:test/test.dart';

void main() {
  group('Filters classes tests', () {

    group('GetContentFilters tests', () {
      test('toQueryParameters method with all parameters', () {
        final getContentFilters = GetContentFilters(publicId: 'test-publicId', legacyMetadata: true);
        final queryParamsMap = getContentFilters.toQueryParametersMap();
        expect(queryParamsMap.length, equals(2));
        expect(queryParamsMap.containsKey('publicId'), isTrue);
        expect(queryParamsMap.containsKey('legacyMetadata'), isTrue);
      });

      test('toQueryParams method will mandatory param publicId', () {
        final getContentFilters = GetContentFilters(publicId: 'test-publicId');
        final queryParamsMap = getContentFilters.toQueryParametersMap();
        expect(queryParamsMap.length, equals(1));
        expect(queryParamsMap.containsKey('publicId'), isTrue);
      });
    });

    group('SearchContentsFilters test', () {
      test('toQueryParams method with only mandatory filters', () {
        final searchContentsFilters = SearchContentsFilters(skip: 0, take: 10);
        final queryParamsMap = searchContentsFilters.toQueryParametersMap();
        expect(queryParamsMap.length, equals(2));
        expect(queryParamsMap.containsKey('skip'), isTrue);
        expect(queryParamsMap.containsKey('take'), isTrue);
      });

      test('toQueryParams method with all filters', () {
        final searchContentsFilters = SearchContentsFilters(
            skip: 0, take: 10, publicId: ['test-publicId'],
            tags: ['tag-1', 'tag-2'],
            repositories: ['repository-1', 'repository-2'],
            contentDefinition: ['definition-1', 'definition-2'],
            sorting: [SortingField(fieldName: 'publicId', ascending: true)],
            propFilters: PropFilters(
                logicalConditions: LogicalConditions.AND,
                propFilerItems: [
                  PropFiltersItem(operator: Operators.CONTAINS, value: 'value-1', field: 'field_name'),
                ]
            )
        );
        final queryParamsMap = searchContentsFilters.toQueryParametersMap();
        expect(queryParamsMap.length, equals(8));
        expect(queryParamsMap.containsKey('skip'), isTrue);
        expect(queryParamsMap.containsKey('take'), isTrue);
        expect(queryParamsMap.containsKey('publicId'), isTrue);
        expect(queryParamsMap.containsKey('tags'), isTrue);
        expect(queryParamsMap.containsKey('repositories'), isTrue);
        expect(queryParamsMap.containsKey('contentDefinition'), isTrue);
        expect(queryParamsMap.containsKey('sorting'), isTrue);
        expect(queryParamsMap.containsKey('propFilters'), isTrue);
      });

    });

    group('LogicalConditions tests', () {
      test('AND logical condition value (used to grup more filterItems in AND condition)', () {
        expect(LogicalConditions.AND.toString(), equals('AND'));
      });
      test('OR logical condition value (used to grup more filterItems in OR condition)', () {
        expect(LogicalConditions.OR.toString(), equals('OR'));
      });
    });

    group('Operators tests', () {
      test('CONTAINTS value (value that containts an other value)', () {
        expect(Operators.CONTAINS.toString(), equals('CONTAINS'));
      });
      test('CONTAINS_IC value (value that contains ignoring case an other value)', () {
        expect(Operators.CONTAINS_IC.toString(), equals('CONTAINS_IC'));
      });
      test('EQUALS value (value that is equals to an other value)', () {
        expect(Operators.EQUALS.toString(), equals('EQUALS'));
      });
      test('EQUALS_IC value (value that is equals ignoring case to an other value)', () {
        expect(Operators.EQUALS_IC.toString(), equals('EQUALS_IC'));
      });
      test('IN value (value inside a list of values)', () {
        expect(Operators.IN.toString(), equals('IN'));
      });
      test('IN_IC value (value inside a list of values ignoring case', () {
        expect(Operators.IN_IC.toString(), equals('IN_IC'));
      });
      test('STARTS_WITH value (value that starts with a value)', () {
        expect(Operators.STARTS_WITH.toString(), equals('STARTS_WITH'));
      });
      test('STARTS_WITH_IC value (value that starts with a value ignoring case', () {
        expect(Operators.STARTS_WITH_IC.toString(), equals('STARTS_WITH_IC'));
      });
    });

    group('SortingField tests', () {
      test('toJson method', () {
        final sortingField = SortingField(ascending: true, fieldName: 'test-field');
        expect(jsonEncode(sortingField), equals(jsonEncode({ 'ascending' : true, 'fieldName': 'test-field' })));
      });
    });

    group('PropFiltersItem tests', () {
      test('toJson method', () {
        final propFiltersItem = PropFiltersItem(field: 'field-name', value: 'field-value', operator: Operators.CONTAINS);
        expect(
          jsonEncode(propFiltersItem),
          equals(jsonEncode({ 'field': 'field-name', 'value': 'field-value', 'operator': Operators.CONTAINS.toString()}))
        );
      });
    });

    group('PropFilters tests', () {
      test('toJson method', () {
        final propFilters = PropFilters(
          logicalConditions: LogicalConditions.AND,
          propFilerItems: [
            PropFiltersItem(field: 'field_1', value: 'value_1', operator: Operators.CONTAINS),
            PropFiltersItem(field: 'field_2', value: 'value_2', operator: Operators.CONTAINS_IC),
          ]
        );
        expect(
          jsonEncode(propFilters),
          equals(jsonEncode({
            'condition': 'AND',
            'items': [{
              'field': 'field_1', 'value': 'value_1', 'operator': 'CONTAINS'
            }, {
              'field': 'field_2', 'value': 'value_2', 'operator': 'CONTAINS_IC'
            }]}))
        );
      });
    });
  });
}
