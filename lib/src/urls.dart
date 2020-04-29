import 'package:meta/meta.dart';
import 'package:contentchef_dart/src/requests_resources.dart';

/// Method used to retrieve the online request path;
///
/// Params:
/// - spaceId: the spaceId of the request
/// - requestType: if the request is a content or a search (i.e. RequestTypes.content for a getContent)
/// - channel: the id of the channel where the content is published
String getOnlinePath(
    {@required String spaceId,
    @required RequestTypes requestType,
    @required String channel}) {
  return '/space/$spaceId/online/$requestType/$channel';
}

/// Method used to retrieve the preview request path;
///
/// Params:
/// - spaceId: the spaceId of the request
/// - requestType: if the request is a content or a search (i.e. RequestTypes.content for a getContent)
/// - status: the publishing status of a content (i.e. PublishingStatus.stage to retrieve contents published in staging)
/// - channel: the id of the channel where the content is published
String getPreviewPath(
    {@required String spaceId,
    @required RequestTypes requestType,
    @required PublishingStatus status,
    @required String channel}) {
  return '/space/$spaceId/preview/$status/$requestType/$channel';
}
