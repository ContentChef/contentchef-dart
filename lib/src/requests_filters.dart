import 'dart:convert';
import 'package:meta/meta.dart';

class GetContentFilters {
  String publicId;

  GetContentFilters({@required this.publicId,});

  Map<String, String> toQueryParametersMap() {
    var getContentFilters = <String, String> {
      'publicId': publicId
    };

    return getContentFilters;
  }
}

class SortingField {
  bool ascending;
  String fieldName;
  SortingField({
    @required this.fieldName,
    @required this.ascending
  });

  Map<String, dynamic> toJson() => {
    'ascending': ascending,
    'fieldName': fieldName,
  };
}

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

class PropFiltersItem {
  String field;
  dynamic value;
  Operators operator;
  PropFiltersItem({
    @required this.field,
    @required this.value,
    @required this.operator
  });

  Map<String, dynamic> toJson() => {
    'field': field,
    'value': value,
    'operator': operator.toString(),
  };
}

class PropFilters {
  LogicalConditions condition;
  List<PropFiltersItem> items;

  PropFilters({
    @required LogicalConditions logicalConditions,
    @required List<PropFiltersItem> propFilerItems
  }) {
    condition = logicalConditions;
    items = propFilerItems;
  }

  Map<String, dynamic> toJson() => {
    'condition': condition.toString(),
    'items': items
  };
}

class SearchContentsFilters {
  int skip;
  int take;
  List<String> publicId;
  List<String> contentDefinition;
  List<String> repositories;
  List<String> tags;
  List<SortingField> sorting;
  PropFilters propFilters;

  SearchContentsFilters({
    @required this.skip,
    @required this.take,
    this.publicId,
    this.contentDefinition,
    this.repositories,
    this.tags,
    this.sorting,
    this.propFilters
  });

  Map<String, String> toQueryParametersMap() {
    var searchFiltersMap = <String, String> {
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
