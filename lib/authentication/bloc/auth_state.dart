
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthenticatingState extends AuthState {}

class FailedToLoadState extends AuthState {
  Error error;
  FailedToLoadState({this.error});
}

class AuthenticatedState extends AuthState {}

class NotAuthenticatedState extends AuthState {}

