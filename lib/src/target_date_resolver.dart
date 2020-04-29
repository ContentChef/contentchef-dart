/// Typedef to describe a valid TargetDateSource
typedef TargetDateDef = Future<String> Function();

/// ContentChef TargetDateResolver Class
///
/// Examples:
///
///     var targetDateResolverWithStringDate = TargetDateResolver(targetDateSource: DateTime.now()');
///     var targetDateResolverWithTargetDateDef = TargetDateResolver(targetDateSource: () async => await DateTime.now());
///
///     N.B. both initialization will return a targetDate defined as TargetDateDet
class TargetDateResolver {
  TargetDateDef _targetDateResolver;

  /// Create an instance of TargetDateResolver
  ///
  /// Parameters:
  /// - targetDateSource: a valid targetDateSource is a String | TargetDetDef
  /// - Returns: an instance of `TargetDateResolver`.
  TargetDateResolver({dynamic targetDateSource}) {
    if (targetDateSource is String || targetDateSource == null) {
      _targetDateResolver = _fixedTargetDate(fixedTargetDate: targetDateSource);
    } else if (targetDateSource is TargetDateDef) {
      _targetDateResolver = targetDateSource;
    } else {
      throw Exception('targetDate must be a string or null or TargetDateDef');
    }
  }

  TargetDateDef _fixedTargetDate({String fixedTargetDate}) {
    return () async {
      return await fixedTargetDate;
    };
  }

  TargetDateDef get targetDate => _targetDateResolver;
}
