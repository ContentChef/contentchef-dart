import 'dart:convert';
import 'package:meta/meta.dart';

/// The getContent request filters configuration
///
/// Examples:
///
///     var baseGetContentFilters = GetContentFilters(publicId: 'content-publicId');
class GetContentFilters {
  String publicId;

  /// Initializes a new `GetContentFilters` needed to retrieve a published content by its publicId.
  ///
  /// Parameters:
  /// - publicId: the published content publicId
  /// - Returns: an instance of `GetContentFilters`.
  GetContentFilters({@required this.publicId});

  /// Method used to transform GetContentFilters class in a queryParams map (Map<String, String>) to encode in request url
  Map<String, String> toQueryParametersMap() {
    var getContentFilters = <String, String>{'publicId': publicId};

    return getContentFilters;
  }
}

/// SortingField filters used in SearchContentFilters to sort contents
/// The request can be sorted for contents generic attributes (onlineDate, offlineDate or publicId) an for content payload attributes
///
/// Examples:
///
///      var sortingField_1 = SortingField(fieldName: onlineDate, ascending: true);
///      var sortingField_2 = SortingField(fieldName: publicId, ascending: false);
///      var sortingField_3 = SortingField(fieldName: 'a-payload-field-name', ascending: true);
///
class SortingField {
  bool ascending;
  String fieldName;

  /// Initializes a new `SortingField`
  ///
  /// Parameters:
  /// - fieldName: the field that you want to use to sort [it can be: onlineDate | offlineDate | publicId | (a payload field name)]
  /// - Returns: an instance of `SortingField`.
  SortingField({@required this.fieldName, @required this.ascending});

  /// Method used to encode SortingField as JSON object
  Map<String, dynamic> toJson() => {
        'ascending': ascending,
        'fieldName': fieldName,
      };
}

/// An enum class that enumerates the PropFilters conditions
///
/// Examples:
///
///      var andCondition = LogicalConditions.AND => (if you want that all PropFilter items filters will be in AND);
///      var orCondition = LogicalConditions.OR => (if you want that all PropFilter items filters will be in OR);
///
class LogicalConditions {
  final String _value;
  const LogicalConditions._(this._value);
  @override
  String toString() {
    return _value;
  }

  static const LogicalConditions AND = LogicalConditions._('AND');
  static const LogicalConditions OR = LogicalConditions._('OR');
}

/// An enum class that enumerates the PropFilterItem operators
///
/// Examples:
///
///      var contains = Operators.CONTAINS; => (if you want that the payload value contains your searched value [CASE SENSITIVE])
///      var containsIC = Operators.CONTAINS_IC; => (if you want that the payload value contains your searched value [CASE INSENSITIVE])
///      var equals = Operators.EQUALS; => (if you want that the payload value is equals to your searched value [CASE SENSITIVE])
///      var equalsIC = Operators.EQUALS_IC; => (if you want that the payload value is equals to your searched value [CASE INSENSITIVE])
///      var in = Operators.IN; => (if the payload value is a list of values, use this operator to search a list that contain your value(s) [CASE SENSITIVE])
///      var inIC = Operators.IN_IC => (if the payload value is a list of values, use this operator to search a list that contain your value(s) [CASE INSENSITIVE])
///      var startsWith = Operators.STARTS_WITH => (if you want that the payload value starts with your searched value [CASE SENSITIVE])
///      var startsWithIC = Operators.STARTS_WITH_IC => (if you want that the payload value starts with your searched value [CASE INSENSITIVE])
///
class Operators {
  final String _value;
  const Operators._(this._value);
  @override
  String toString() {
    return _value;
  }

  static const Operators CONTAINS = Operators._('CONTAINS');
  static const Operators CONTAINS_IC = Operators._('CONTAINS_IC');
  static const Operators EQUALS = Operators._('EQUALS');
  static const Operators EQUALS_IC = Operators._('EQUALS_IC');
  static const Operators IN = Operators._('IN');
  static const Operators IN_IC = Operators._('IN_IC');
  static const Operators STARTS_WITH = Operators._('STARTS_WITH');
  static const Operators STARTS_WITH_IC = Operators._('STARTS_WITH_IC');
}

/// PropFilterItem used as item inside PropFilters
///
/// Examples:
///
///      var propFilterItem_1 = PropFilterItem(field: 'an-indexed-content-field', value: 'the field value', operator: Operators.CONTAIN);
///      var propFilterItem_2 = PropFilterItem(field: 'an-indexed-content-field', value: 10, operator: Operators.EQUALS);
///      var propFilterItem_3 = PropFilterItem(field: 'an-indexed-content-field', value: ['value_1, 'value_2]', operator: Operators.IN);
///
class PropFiltersItem {
  String field;
  dynamic value;
  Operators operator;

  /// Initializes a new `PropFilterItem`
  ///
  /// Parameters:
  /// - field: the name of the field that you want to compare it's value
  /// - value: the value that you want to search
  /// - operator: instance of Operators;
  /// - Returns: an instance of `SortingField`.
  ///
  PropFiltersItem(
      {@required this.field, @required this.value, @required this.operator});

  /// Method used to encode SortingField as JSON object
  Map<String, dynamic> toJson() => {
        'field': field,
        'value': value,
        'operator': operator.toString(),
      };
}

/// PropFilter used to search contents that match the criteria inside the items attribute
///
/// Examples:
///
///      var propFilters_1 = PropFilters(logicalCondition: LogicalCondition.AND, items: [PropFilterItem(...), PropFilterItem(...)]);
///      var propFilters_2 = PropFilters(logicalCondition: LogicalCondition.OR, items: [PropFilterItem(...), PropFilterItem(...)]);
///
class PropFilters {
  LogicalConditions condition;
  List<PropFiltersItem> items;

  /// Initializes a new `PropFilters`
  ///
  /// Parameters:
  /// - logicalCondition: instance of LogicalConditions
  /// - items: List of PropFilterItem instance
  /// - Returns: an instance of `PropFilters`.
  ///
  PropFilters(
      {@required LogicalConditions logicalCondition,
      @required List<PropFiltersItem> propFilerItems}) {
    condition = logicalCondition;
    items = propFilerItems;
  }

  /// Method used to encode SortingField as JSON object
  Map<String, dynamic> toJson() =>
      {'condition': condition.toString(), 'items': items};
}

/// The searchContents request filters configuration
///
/// Examples:
///
///     var baseSearchContentsFilters = SearchContentsFilters(take: 0, skip: 10);
///
class SearchContentsFilters {
  int skip;
  int take;
  List<String> publicId;
  List<String> contentDefinition;
  List<String> repositories;
  List<String> tags;
  List<SortingField> sorting;
  PropFilters propFilters;

  /// Initializes a new `SearchContentsFilters`
  ///
  /// Parameters:
  /// - take: the number of contents to retrieve in the search
  /// - skip: the number of contents to skip in the search
  /// - publicId: List of contents publicId to search (contents published with the specified publicIds will be retrieved)
  /// - contentDefinition: List of contentDefinition mnemonicIds (contents published with the specified contentDefinitions will be retrieved)
  /// - repositories: List of repository mnemonicIds (contents published with the specified repositories will be retrieved)
  /// - tags: List of tags (contents that contains the specified tags will be retrieve)
  /// - sorting: List of SortingField instance (used to sort the search for the specified sorting filters)
  /// - propFilters: instance of PropFilters
  /// - Returns: an instance of `SearchContentsFilters`.
  ///
  SearchContentsFilters(
      {@required this.skip,
      @required this.take,
      this.publicId,
      this.contentDefinition,
      this.repositories,
      this.tags,
      this.sorting,
      this.propFilters});

  /// Method used to transform SearchContentsFilters in a queryParams map (Map<String, String>) to encode in request url
  Map<String, String> toQueryParametersMap() {
    var searchFiltersMap = <String, String>{
      'skip': skip.toString(),
      'take': take.toString(),
    };
    if (publicId != null) {
      searchFiltersMap['publicId'] = publicId.toString();
    }
    if (contentDefinition != null) {
      searchFiltersMap['contentDefinition'] = contentDefinition.toString();
    }
    if (repositories != null) {
      searchFiltersMap['repositories'] = repositories.toString();
    }
    if (tags != null) {
      searchFiltersMap['tags'] = tags.toString();
    }
    if (sorting != null) {
      searchFiltersMap['sorting'] = jsonEncode(sorting);
    }
    if (propFilters != null) {
      searchFiltersMap['propFilters'] = jsonEncode(propFilters);
    }
    return searchFiltersMap;
  }
}
