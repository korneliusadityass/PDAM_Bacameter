import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable implements Exception {
  final String message;

  const Failure(this.message);

  @override
  List<Object> get props => [message];
}

class UIFailure extends Failure {
  const UIFailure(super.message);
}

class ServerFailure extends Failure {
  const ServerFailure(super.message);
}

class ConnectionFailure extends Failure {
  const ConnectionFailure(super.message);
}

class DatabaseFailure extends Failure {
  const DatabaseFailure(super.message);
}

class SessionFailure extends Failure {
  const SessionFailure(super.message);
}

class UserCancelledException extends Failure {
  const UserCancelledException(super.message);
}