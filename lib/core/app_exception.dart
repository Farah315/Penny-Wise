import 'package:equatable/equatable.dart';

abstract class AppException extends Equatable {
  final String message;

  const AppException(this.message);

  @override
  List<Object> get props => [message];
}

class ServerFailure extends AppException {
  const ServerFailure(super.message);
}

class CacheFailure extends AppException {
  const CacheFailure(super.message);
}

class NetworkFailure extends AppException {
  const NetworkFailure(super.message);
}

class AuthFailure extends AppException {
  const AuthFailure(super.message);
}

class ValidationFailure extends AppException {
  const ValidationFailure(super.message);
}