/// FromJsonDef<T>
/// A helper method used to serialize the ContentChef content retrieved from the get or search api request
///
typedef FromJsonDef<T> = T Function(Map<String, dynamic> json);

/// ContentChef responseMetadata class mapper
///
class ResponseMetadata {
  int authoringContentId;
  int contentVersion;
  int id;
  String contentLastModifiedDate;
  String publishedOn;
  List<String> tags;

  /// Create a `ResponseMetadata` instance
  ///
  /// Parameters:
  /// - authoringContentId: int (the content authoring unique id)
  /// - contentLastModifiedDate: String (the content last modified date string)
  /// - contentVersion: int (the published content version)
  /// - id: int (the published content unique id)
  /// - publishedOn: String (the content published date string)
  /// - tags: List<String> (the content related tags)
  /// - Returns: an instance of ResponseMetadata;
  ///
  ResponseMetadata({
    this.authoringContentId,
    this.contentLastModifiedDate,
    this.contentVersion,
    this.id,
    this.publishedOn,
    this.tags
  });

  /// Create an instance of ResponseMetadata from a JSON object
  ///
  /// Parameters:
  /// - json: the json object to serialize as a ResponseMetadata class
  /// - Returns: an instance of ResponseMetadata
  factory ResponseMetadata.fromJson(Map<String, dynamic> json) {
    return ResponseMetadata(
        authoringContentId: json['authoringContentId'] as int,
        contentVersion: json['contentVersion'] as int,
        id: json['id'] as int,
        contentLastModifiedDate: json['contentLastModifiedDate'] as String,
        publishedOn: json['publishedOn'] as String,
        tags: List<String>.from(json['tags'])
    );
  }

  /// Method used to deserialize a ResponseMetadata class to JSON object
  ///
  Map<String, dynamic> toJson() => {
        'authoringContentId': authoringContentId,
        'contentVersion': contentVersion,
        'id': id,
        'contentLastModifiedDate': contentLastModifiedDate,
        'publishedOn': publishedOn,
        'tags': tags,
      };
}

/// ContentChef RequestContents class mapper
///
class RequestContext {
  String publishingChannel;
  String targetDate;
  String cloudName;
  String timestamp;

  /// Create a `RequestContextInstance` instance.
  ///
  /// Parameters:
  /// - publishingChannel: String (request publishing channel)
  /// - targetDate: String (request target date)
  /// - cloudName: String (media cloud name reference)
  /// - timestamp: String (request timestamp)
  /// - Returns: an instance of 'RequestContext'
  ///
  RequestContext({
    this.publishingChannel,
    this.targetDate,
    this.cloudName,
    this.timestamp
  });

  /// Create an instance of RequestContext from a json Map
  ///
  /// Parameters:
  /// - json: the json object to serialize as a RequestContext class
  /// - Returns: an instance of RequestContext
  ///
  factory RequestContext.fromJson(Map<String, dynamic> json) {
    return RequestContext(
      publishingChannel: json['publishingChannel'] as String,
      targetDate: json['targetDate'] as String,
      cloudName: json['cloudName'] as String,
      timestamp: json['timestamp'] as String,
    );
  }

  /// Method used to deserialize a RequestContext class to JSON object
  ///
  Map<String, dynamic> toJson() => {
        'publishingChannel': publishingChannel,
        'targetDate': targetDate,
        'cloudName': cloudName,
        'timestamp': timestamp
      };
}

/// ContentChef ContentResponse class mapper for a specified content of type T
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

  /// Create a `ContentResponse<T>` instance.
  ///
  ///  Parameters:
  ///  - definition: String (content definition mnemonicId for the content)
  ///  - repository: String (repository mnemonicId for the content)
  ///  - publicId: String (content publicId)
  ///  - offlineDate: String (content offline date)
  ///  - onlineDate: String (content online date)
  ///  - metadata: ResponseMetadata (instance of ResponseMetadata)
  ///  - payload: T (instance of a class T)
  ///  - requestContext: RequestContext (instance of RequestContext);
  /// - Returns: an instance of 'ContentResponse'
  ///
  ContentResponse({
    this.definition,
    this.repository,
    this.publicId,
    this.offlineDate,
    this.onlineDate,
    this.metadata,
    this.payload,
    this.requestContext
  });

  /// Create an instance of ContentResponse from a json Map
  ///
  /// Parameters:
  /// - json: the json object to serialize as a ContentResponse<T> class
  /// - fromJson: FromJsonDef<T> function (used to serialize payload attribute as instance of T)
  /// - Returns: an instance of RequestContext
  ///
  factory ContentResponse.fromJson(Map<String, dynamic> json, FromJsonDef<T> fromJson) {
    return ContentResponse(
      definition: json['definition'] as String,
      repository: json['repository'] as String,
      publicId: json['publicId'] as String,
      metadata: ResponseMetadata.fromJson(json['metadata']),
      offlineDate: json['offlineDate'] as String,
      onlineDate: json['onlineDate'] as String,
      payload: fromJson(json['payload']) ,
      requestContext: RequestContext.fromJson(json['requestContext']),
    );
  }

  /// Method used to deserialize a ContentResponse class to JSON object
  ///
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

/// ContentChef PaginatedResponse class mapper for a specified contents of type T
///
class PaginatedResponse<T> {
  List<ContentResponse<T>> items;
  int total;
  int skip;
  int take;
  RequestContext requestContext;

  /// Create a `PaginatedResponse<T>` instance.
  ///
  ///  Parameters:
  ///  - items: List<ContentResponse<T> (a list of ContentResponse<T> instance)
  ///  - total: int (number of contents find in the search request)
  ///  - skip: int (number of contents skipped in the search request)
  ///  - take: int (number of contents taken in the search request)
  ///  - requestContext: String (content online date)
  ///  - Returns: an instance of 'PaginatedResponse<T>'
  ///
  PaginatedResponse({
    this.items,
    this.total,
    this.skip,
    this.take,
    this.requestContext,
  });

  /// Create a `PaginatedResponse<T>` instance from a json object.
  ///
  /// Parameters:
  /// - json: the json object to serialize as a PaginatedResponse<T> class
  /// - fromJson: FromJsonDef<T> function (used to serialize the items payload attribute as instance of T)
  /// - Returns: an instance of 'PaginatedResponse'
  ///
  factory PaginatedResponse.fromJson(Map<String, dynamic> json, FromJsonDef<T> fromJson) {
    return PaginatedResponse(
      items: List<ContentResponse<T>>.from(json['items'].map((item) => ContentResponse<T>.fromJson(item, fromJson))),
      total: json['total'] as int,
      skip: json['skip'] as int,
      take: json['take'] as int,
      requestContext: RequestContext.fromJson(json['requestContext']),
    );
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
