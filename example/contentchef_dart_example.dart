import 'dart:convert';

import 'package:contentchef_dart/contentchef_dart.dart';

/// This class is used to map a content of type "top-site"
///
class TopSiteContent {
  String title;
  String description;
  String url;
  String image;

  TopSiteContent({this.title, this.description, this.url, this.image});

  static TopSiteContent fromJson(Map<String, dynamic> json) {
    return TopSiteContent(
        title: json['title'] as String,
        description: json['description'] as String,
        url: json['description'] as String,
        image: json['image'] as String
    );
  }

  // Method needed to deserialize TopSiteContent class in JSON object
  Map<String, dynamic> toJson() => {
    'title': title,
    'description': description,
    'url': url,
    'image': image
  };
}

void main() async {
  var configuration = Configuration(spaceId: 'yours-spaceId');

  var contentChef = ContentChef(configuration: configuration);

  try {
    var result = await contentChef
      .getPreviewChannel(apiKey: 'test-api-key', status: PublishingStatus.stage, publishingChannel: 'your-channel-mnemonicId')
      .searchContents<TopSiteContent>(
        filters: SearchContentsFilters(skip: 0, take: 10, contentDefinition: ['top-site']),
        fromJson: TopSiteContent.fromJson);
      print(jsonEncode(result));
  } catch (e) {
    print(e);
  }
}
