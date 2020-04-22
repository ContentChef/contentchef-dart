import 'package:meta/meta.dart';
import 'package:contentchef_dart/src/requests_resources.dart';

String getOnlinePath({
  @required String spaceId,
  @required RequestTypes requestType,
  @required String channel
}) {
  return '/space/$spaceId/online/$requestType/$channel';
}

String getPreviewPath({
  @required String spaceId,
  @required RequestTypes requestType,
  @required PublishingStatus status,
  @required String channel
}) {
  return '/space/$spaceId/preview/$status/$requestType/$channel';
}
