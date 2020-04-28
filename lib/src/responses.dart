/// ContentChef responseMetadata class mapper
///
class ResponseMetadata {
  int authoringContentId;
  int contentVersion;
  int id;
  String contentLastModifiedDate;
  String publishedOn;
  List<String> tags;

  /// Create a `ResponseMetadata` instance from a json object.
  ///
  /// Parameters:
  /// - data: a json object to transform
  /// - Returns: an instance of 'ResponseMetadata;
  ///
  ResponseMetadata(Map<String, dynamic> data) {
    authoringContentId = data['authoringContentId'];
    contentLastModifiedDate = data['contentLastModifiedDate'];
    contentVersion = data['contentVersion'];
    id = data['id'];
    publishedOn = data['publishedOn'];
    tags = List<String>.from(data['tags']);
  }

  /// Method used to encode SortingField as JSON object
  Map<String, dynamic> toJson() => {
    'authoringContentId': authoringContentId,
    'contentVersion': contentVersion,
    'id': id,
    'contentLastModifiedDate': contentLastModifiedDate,
    'publishedOn': publishedOn,
    'tags': tags,
  };
}

/// ContentChef requestContents class mapper
///
class RequestContext {
  String publishingChannel;
  String targetDate;
  String cloudName;
  String timestamp;

  /// Create a `RequestContextInstance` instance from a json object.
  ///
  /// Parameters:
  /// - data: a json object to transform
  /// - Returns: an instance of 'RequestContext'
  ///
  RequestContext(Map<String, dynamic> data) {
    publishingChannel = data['publishingChannel'];
    targetDate = data['targetDate'];
    cloudName = data['cloudName'];
    timestamp = data['timestamp'];
  }

  /// Method used to encode SortingField as JSON object
  Map<String, dynamic> toJson() => {
    'publishingChannel': publishingChannel,
    'targetDate': targetDate,
    'cloudName': cloudName,
    'timestamp': timestamp
  };
}

/// ContentChef ContentResponse class mapper for a specified content T
///
class ContentResponse<T> {
  String definition;
  String repository;
  String publicId;
  String offlineDate;
  String onlineDate;
  ResponseMetadata metadata;
  T payload;
  RequestContext requestContext;

  /// Create a `ContentResponse<T>` instance from a json object.
  ///
  /// Parameters:
  /// - data: a json object to transform
  /// - Returns: an instance of 'ContentResponse'
  ///
  ContentResponse(Map<String, dynamic> data) {
    definition = data['definition'];
    repository = data['repository'];
    publicId = data['publicId'];
    metadata = ResponseMetadata(data['metadata']);
    offlineDate = data['offlieDate'];
    onlineDate = data['onlineDate'];
    payload = data['payload'];
    requestContext = RequestContext(data['requestContext']);
  }

  /// Method used to encode SortingField as JSON object
  Map<String, dynamic> toJson() => {
    'definition': definition,
    'repository': repository,
    'publicId': publicId,
    'offlineDate': offlineDate,
    'onlineDate': onlineDate,
    'metadata': metadata,
    'payload': payload,
    'requestContext': requestContext,
  };
}

class PaginatedResponse<T> {
  List<ContentResponse<T>> items;
  int total;
  int skip;
  int take;
  RequestContext requestContext;

  /// Create a `PaginatedResponse<T>` instance from a json object.
  ///
  /// Parameters:
  /// - data: a json object to transform
  /// - Returns: an instance of 'PaginatedResponse'
  ///
  PaginatedResponse(Map<String, dynamic> data) {
    items = List<ContentResponse<T>>.from(data['items'].map((item)=> ContentResponse(item)));
    total = data['total'];
    skip = data['skip'];
    take = data['take'];
    requestContext = RequestContext(data['requestContext']);
  }

  /// Method used to encode SortingField as JSON object
  Map<String, dynamic> toJson() {
    return {
      'total': total,
      'skip': skip,
      'take': take,
      'requestContext': requestContext,
      'items': items
    };
  }
}
