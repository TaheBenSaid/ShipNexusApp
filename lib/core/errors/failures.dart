import 'package:equatable/equatable.dart';

import '../strings/messages.dart';

abstract class Failure extends Equatable {}

class OfflineFailure extends Failure {
  final String message;

  OfflineFailure({this.message = OFFLINE_FAILURE_MESSAGE});

  @override
  List<Object?> get props => [];
}

class ServerFailure extends Failure {
  final String message;

  ServerFailure({required this.message});

  @override
  List<Object?> get props => [message];
}

class UnknownFailure extends Failure {
  final String message;

  UnknownFailure(
      {this.message =
          "This service is temporarily unavailable,please try again later"});

  @override
  List<Object?> get props => [message];
}
