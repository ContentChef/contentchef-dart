import 'dart:convert';

import 'package:contentchef_dart/contentchef_dart.dart';

void main() async {
  var configuration = Configuration(spaceId: 'yours-spaceId');

  var contentChef = ContentChef(configuration: configuration);

  try {
    var result = await contentChef
      .getPreviewChannel(apiKey: 'test-api-key', status: PublishingStatus.stage, publishingChannel: 'your-channel-mnemonicId')
      .searchContents(filters: SearchContentsFilters(skip: 0, take: 10));
      print(jsonEncode(result));
  } catch (e) {
    print(e);
  }
}
