import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'auth_state.dart';
import 'package:flutter_blog_tech_test/repository/post_api_client.dart';

part 'auth_event.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final _postAPIClient = PostAPIClient();
  String token = "";
  AuthBloc() : super(AuthInitial());

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if(event is LoginEvent){
      yield AuthenticatingState();

      try {
        token = await _postAPIClient.login(event.email,event.password);
      } catch (e) {
        yield FailedToLoadState(error: e);
      }
      yield AuthenticatedState();
    }
  }
}
