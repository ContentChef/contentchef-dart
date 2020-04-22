A ContentChef library for Dart developers.

## Usage

A simple usage example:

```dart
import 'package:contentchef_dart/contentchef_dart.dart';

void main() async {
  var configuration = Configuration(spaceId: 'your-space-id');
  var contentChef = ContentChef(configuration, targetDateResolver);

  try {
      var result = await contentChef
        .getPreviewChannel(apiKey: 'your-preview-key', status: PublishingStatus.stage, publishingChannel: 'publisning-channelId')
        .searchContents(filters: SearchContentsFilters(skip: 0, take: 10));
      print(jsonEncode(result));
  } catch (e) {
      print(e); 
  }
}
```
