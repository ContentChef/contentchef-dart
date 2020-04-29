import 'package:meta/meta.dart';

class DefaultError {
  String type;
  int code;

  DefaultError({
    @required this.type,
    @required this.code,
  });

  Map<String, dynamic> toJson() => {
        'type': type,
        'code': code,
      };
}

class BadRequestException extends DefaultError {
  Map<String, dynamic> error;

  BadRequestException({
    @required int code,
    @required Map<String, dynamic> error,
  }) : super(type: 'BadRequestException', code: code) {
    this.error = error;
  }

  @override
  Map<String, dynamic> toJson() => {'type': type, 'code': code, 'error': error};
}

class ForbiddenException extends DefaultError {
  ForbiddenException({@required int code})
      : super(type: 'ForbiddenError', code: code);
}

class NotFoundException extends DefaultError {
  NotFoundException({@required int code})
      : super(type: 'NotFoundError', code: code);
}

class GenericErrorException extends DefaultError {
  GenericErrorException({@required int code})
      : super(type: 'GenericError', code: code);
}
