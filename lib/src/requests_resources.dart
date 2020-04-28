
/// An enum class that enumerates the type of requests
///
/// Examples:
///
///      var contentRequest = RequestTypes.content;
class RequestTypes {
  final String _value;
  const RequestTypes._(this._value);
  @override
  String toString() {
    return _value;
  }
  static const RequestTypes content = RequestTypes._('content');
  static const RequestTypes search = RequestTypes._('search/v2');
}

/// An enum class that enumerates the type of publishing status
///
/// Examples:
///
///      var stageStatus = PublishingStatus.stage;
class PublishingStatus {
  final String _value;
  const PublishingStatus._(this._value);
  @override
  String toString() {
    return _value;
  }
  static const PublishingStatus stage = PublishingStatus._('staging');
  static const PublishingStatus live = PublishingStatus._('live');
}
