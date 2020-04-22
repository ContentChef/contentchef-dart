typedef TargetDateDef = Future<String> Function();

class TargetDateResolver {
  TargetDateDef _targetDateResolver;

  TargetDateResolver({ dynamic targetDateSource }) {
    if (targetDateSource is String || targetDateSource == null) {
      _targetDateResolver = _fixedTargetDate(fixedTargetDate: targetDateSource);
    } else if (targetDateSource is TargetDateDef) {
      _targetDateResolver = targetDateSource;
    } else {
      throw Exception('targetDate must be a string or null or TargetDateDef');
    }
  }

  TargetDateDef _fixedTargetDate({ String fixedTargetDate }) {
    return () async { return await fixedTargetDate; };
  }

  TargetDateDef get targetDate => _targetDateResolver;
}
