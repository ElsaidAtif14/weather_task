import 'package:dio/dio.dart';
import 'package:weather/core/errors/error_model.dart';

//! ServerException
class ServerException implements Exception {
  final ErrorModel errorModel;
  ServerException(this.errorModel);
}

//! CacheException
class CacheException implements Exception {
  final String errorMessage;
  CacheException({required this.errorMessage});
}

class BadCertificateException extends ServerException {
  BadCertificateException(super.errorModel);
}

class ConnectionTimeoutException extends ServerException {
  ConnectionTimeoutException(super.errorModel);
}

class BadResponseException extends ServerException {
  BadResponseException(super.errorModel);
}

class ReceiveTimeoutException extends ServerException {
  ReceiveTimeoutException(super.errorModel);
}

class ConnectionErrorException extends ServerException {
  ConnectionErrorException(super.errorModel);
}

class SendTimeoutException extends ServerException {
  SendTimeoutException(super.errorModel);
}

class UnauthorizedException extends ServerException {
  UnauthorizedException(super.errorModel);
}

class ForbiddenException extends ServerException {
  ForbiddenException(super.errorModel);
}

class NotFoundException extends ServerException {
  NotFoundException(super.errorModel);
}

class CofficientException extends ServerException {
  CofficientException(super.errorModel);
}

class CancelException extends ServerException {
  CancelException(super.errorModel);
}

class UnknownException extends ServerException {
  UnknownException(super.errorModel);
}

void handleDioException(DioException e) {
  /*
    هذه الدالة المساعدة تتأكد من نوع البيانات قبل تمريرها للـ Model
    لو البيانات Map (JSON) بتستخدم الـ fromJson
    لو البيانات String أو الـ Response نل، بتعمل Model يدوي
  */
  ErrorModel getErrorModel(Response? response) {
    if (response != null && response.data != null && response.data is Map) {
      return ErrorModel.fromJson(response.data);
    } else {
      return ErrorModel(
        status: response?.statusCode ?? 500,
        errorMessage: response?.data?.toString() ?? e.message ?? "Unexpected Error Occurred",
      );
    }
  }

  switch (e.type) {
    case DioExceptionType.connectionError:
      throw ConnectionErrorException(getErrorModel(e.response));

    case DioExceptionType.badCertificate:
      throw BadCertificateException(getErrorModel(e.response));

    case DioExceptionType.connectionTimeout:
      throw ConnectionTimeoutException(getErrorModel(e.response));

    case DioExceptionType.receiveTimeout:
      throw ReceiveTimeoutException(getErrorModel(e.response));

    case DioExceptionType.sendTimeout:
      throw SendTimeoutException(getErrorModel(e.response));

    case DioExceptionType.badResponse:
      switch (e.response?.statusCode) {
        case 400: // Bad request
          throw BadResponseException(getErrorModel(e.response));

        case 401: // Unauthorized
          throw UnauthorizedException(getErrorModel(e.response));

        case 403: // Forbidden
          throw ForbiddenException(getErrorModel(e.response));

        case 404: // Not found
          throw NotFoundException(getErrorModel(e.response));

        case 409: // Conflict
          throw CofficientException(getErrorModel(e.response));

        default:
          throw ServerException(getErrorModel(e.response));
      }

    case DioExceptionType.cancel:
      throw CancelException(
        ErrorModel(errorMessage: "Request to API server was cancelled", status: 500),
      );

    case DioExceptionType.unknown:
    throw UnknownException(
        ErrorModel(errorMessage: e.message ?? "Unknown error", status: 500),
      );
    case DioExceptionType.transformTimeout:
      // TODO: Handle this case.
      throw UnimplementedError();
  }
}