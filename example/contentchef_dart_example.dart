import 'dart:convert';

import 'package:contentchef_dart/contentchef_dart.dart';

void main() async {
  var configuration = Configuration(timeout: 15000, spaceId: 'localnick01-3914', host: 'go326hjrhh.execute-api.eu-west-1.amazonaws.com');
  var targetDateResolver = TargetDateResolver(targetDateSource: DateTime.now().toIso8601String());
  var contentChef = ContentChef(configuration: configuration, targetDateResolver: targetDateResolver);

  try {
    var result = await contentChef
      .getPreviewChannel(apiKey: 'test-api-key', status: PublishingStatus.stage, publishingChannel: 'depc')
      .searchContents(
        filters: SearchContentsFilters(
            skip: 0, take: 10,
            sorting: [
              SortingField(ascending: true, fieldName: 'publicId'),
              SortingField(ascending: false, fieldName: 'title')
            ],
            propFilters: PropFilters(
                logicalConditions: LogicalConditions.OR,
                propFilerItems: [
                  PropFiltersItem(operator: Operators.CONTAINS_IC, value: 'Google', field: 'title'),
                  PropFiltersItem(operator: Operators.CONTAINS_IC, value: 'Amazon', field: 'title'),
                ]
            )
        )
      );
    print(jsonEncode(result));
  } catch (e) {
    print(e);
  }
}
