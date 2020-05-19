# ContentChef Dart/Flutter SDK

Welcome to [ContentChef API-First CMS's](https://www.contentchef.io/) Dart/Flutter SDK.

## How to use ContentChef client

**Dart/Flutter**

Create your ContentChef instance like this:

```
    import 'package:contentchef_dart/contentchef_dart.dart';
    
    void main() {

        var configuration = Configuration(spaceId: SPACE_ID);
        var contentChef = (configuration: configuration);

    }
```

*SPACE_ID* can be retrieved from your [ContentChef's dashboard](https://app.contentchef.io/).

You can now use your `contentChef` instance to get the channel you want to use to retrieve info: you have two channels, the `OnlineChannel` and the `PreviewChannel`.

With the `OnlineChannel` you can retrieve contents which are in _live_ state and which are actually visible, while with the `PreviewChannel` you can retrieve contents which are in in both **stage** and **live** states and even contents that are not visible in the current date.

Both the `OnlineChannel` and the `PreviewChannel` have two methods which are `getContent()` and `searchContents()`

You can use the `getContent()` method to collect a specific content by its own `publicId`, for example to retrieve a single post from your blog, a single image from a gallery or a set of articles from your featured articles list. Otherwise you can use the `searchContents()` method to find contents with multiple matching criteria, like content definition name, publishing dates and more.

### Examples

#### How to retrieve a content from your OnlineChannel

*SPACE_ID* can be retrieved from your [ContentChef's dashboard](https://app.contentchef.io/).

*ONLINE_API_KEY* can be retrieved from your [ContentChef space homepage](https://app.contentchef.io).

*PUBLISHING_CHANNEL* can be retrieved from your [ContentChef's dashboard](https://app.contentchef.io).

``` dart

    /// Retrieve the *content-chef-site* content from the live status:

    void main() {

        var configuration = Configuration(spaceId: SPACE_ID);
        
        var contentChef = (configuration: configuration);

        var getContentFilters = GetContentFilters(publicId: 'content-chef-site');
    
        var onlineChannel = contentChef.getOnlineChannel(apiKey: ONLINE_API_KEY, publishingChannel: PUBLISHING_CHANNEL);

        try {
            var result = await onlineChannel.getContent(filters: getContentFilters);
            print(jsonEncode(result));
        } catch(e) { 
            print(jsonEncode(e));
        }

    }

```

#### How to retrieve a content in the future from your PreviewChannel

*SPACE_ID* can be retrieved from your [ContentChef's dashboard](https://app.contentchef.io/).

*PREVIEW_API_KEY* can be retrieved from your [ContentChef space homepage](https://app.contentchef.io).

*PUBLISHING_CHANNEL* can be retrieved from your [ContentChef's dashboard](https://app.contentchef.io).

``` dart

    // Preview the content *content-chef-site* content in a given future date from the live status
    // (i.e. if you want to see the content that will be online in 10 days)
    // **targetDateResolver** is used only in the PreviewChannel
    // targetDateResolver always return a TargetDate as a `TargetDateDef` so that you can change your date dynamically without caring to create a new ContentChef instance
    
    void main() {

        var configuration = Configuration(spaceId: SPACE_ID);
        
        var aDate10DaysInFuture = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + 10);
        vart targetDateResolver = TargetDateResolver(targetDateSource: aDate10DaysInFuture.toIso8601String());

        var contentChef = (configuration: configuration, targetDateResolver: targetDateResolver);

        var getContentFilters = GetContentFilters(publicId: 'content-chef-site');
        
        var previewChannel = contentChef.previewChannel(apiKey: PREVIEW_API_KEY, publishingChannel: PUBLISHING_CHANNEL, status: PublishingStatus.live);
        
        try {
            var result = await previewChannel.getContent(filters: getContentFilters);
            print(jsonEncode(result));
        } catch(e) { 
            print(jsonEncode(e));
        }
    }
      
```

#### How to Search for all the contents of a specific definition

*SPACE_ID* can be retrieved from your [ContentChef's dashboard](https://app.contentchef.io/).

*ONLINE_API_KEY* can be retrieved from your [ContentChef space homepage](https://app.contentchef.io).

*PUBLISHING_CHANNEL* can be retrieved from your [ContentChef's dashboard](https://app.contentchef.io).

```
 
    // Search for 10 the contents created using the definition *content-chef-site*
   
    void main() {

        var configuration = Configuration(spaceId: SPACE_ID);

        var searchContentFilters = SearchContentsFilters(skip: 0, take: 10, contentDefinition: ['top-sites']);

        var contentChef = (configuration: configuration);
        
        var onlineChannel = contentChef.onlineChannel(apiKey: ONLINE_API_KEY, publishingChannel: PUBLISHING_CHANNEL);
        
        try {
            var result = await previewChannel.searchContents(filters: searchContentFilters);
            print(jsonEncode(result));
        } catch(e) { 
            print(jsonEncode(e))
        }
    }

```

## How to use Media helper

 If you request a content that contain a media field, it will return its publicId as value of the field.
 In order to retrieve the media public url, you will need to use the `Media` helper class.
 
### Examples 

#### How to retrieve a media without transformations

``` dart

    void main() {
    
        var mediaHelper = Media();
        var publicUrl = mediaHelper.getUrl(publicId: 'your-field-media-publicId')

        print(publicUrl);

    }

```

#### How to retrieve a media without transformations

``` dart
    
    // If you desire to have transformed media you can specify some parameters with the transformation parameter while getting your media publicUrl.
    // The possible transformations are: mediaHeight, mediaWidth, autoFormat and mediaFormat, for more information refer to `MediaTransformations` class

    void main() {
    
        var mediaHelper = Media();
        var transformations = MediaTransformations(mediaWidth: 1000, mediaHeight: 1000);
        var publicUrl = mediaHelper.getUrl(publicId: 'your-field-media-publicId', transformations: transformations);

        print(publicUrl);

    }

```


## Installation

1. Depend on it
    
Add this to your package's pubspec.yaml file:

``` yaml

    dependencies:
        contentchef_dart: ^1.0.3

```

2. Install it

You can install packages from the command line:

with pub:

```shell

    $ pub get

```

with Flutter:

```shell

    $ flutter pub get

```

Alternatively, your editor might support pub get or flutter pub get. Check the docs for your editor to learn more.

3. Import it

Now in your Dart code, you can use:

``` dart

import 'package:contentchef_dart/contentchef_dart.dart';

```
  
