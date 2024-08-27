import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final List properties;
  const Failure([this.properties = const <dynamic>[]]);

  @override
  List<Object> get props => [properties];
}

class ServerFailure extends Failure {
  const ServerFailure([super.properties]);
}

class NetworkFailure extends Failure {
  const NetworkFailure([super.properties]);
}
