## 1.2.0
- add `VideoTransformations` with new transformations `croppingMode` and `quality`
- change `videoUrl` now transformations defaults to a `VideoTransformations` with `autoFormat` set to `true` and `quality` to `auto`

## 1.1.0

- add `ResourceType` enum to `Media`
- add `rawFileUrl`, `videoUrl` and `imageUrl` to `Media`
- change `getUrl` to consider the provided `resourceType` and build the url accordingly

## 1.0.5

- encode url from `getUrl` media's method

## 1.0.4

- change apiKey header name from `X-SPACE-D-API-Key` to `X-Chef-Key`

## 1.0.3

- add `fromJson` param in `GetContent` and `SearchContents` methods to help the user to serialize contents payload 

## 1.0.2

- Change usage Uri.https in favour of Uri to better handle search query parameters as Iterable<String>

## 1.0.1

- Add github repository link

## 1.0.0

- Initial version, created by ContentChef team
