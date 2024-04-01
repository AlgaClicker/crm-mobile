
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

part 'login_page_event.dart';
part 'login_page_state.dart';

class LoginPageBloc extends Bloc<LoginPageEvent, LoginPageState> {


  

  LoginPageBloc() :  super(LoginPageStateInitial()) {
    on<LoginPageEventInitial>(_loginPageInitial);
    on<LoginPageEventSubmitted>(_loginPageEventSubmitted);
    on<UsernameFieldChange>(_usernameFieldChange);
    on<PasswordFieldChange>(_passwordFieldChange);
    
  }

  _passwordFieldChange(PasswordFieldChange event, Emitter<LoginPageState> emit) {
    emit(state.copyWith(
      password: event.password.trim()
    ));
  }

  _usernameFieldChange (UsernameFieldChange event, Emitter<LoginPageState> emit) {
    emit(state.copyWith(
      username: event.username.trim()
    ));
  }

  _loginPageInitial(LoginPageEvent event, Emitter<LoginPageState> emit) {
    debugPrint('LoginPageBloc::_loginPageInitial');
  } 

  _loginPageEventSubmitted(LoginPageEvent event, Emitter<LoginPageState> emit) {
      debugPrint('LoginPageBloc::_loginPageEventSubmitted');
  } 




}
