
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_alga_crm/domain/entity/account/account.dart';
import 'package:mobile_alga_crm/repository/systems/authentication_repository.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationRepository authenticationRepository;

  AuthenticationBloc({required this.authenticationRepository}) : super(AuthenticationInitial()) {
    on<AuthenticationEventLogIn>(_authenticationEventLogIn);
    on<AuthenticationEventCheckToken>(_authenticationEventCheckToken);
    on<AuthenticationEventLogOut>(_authenticationEventLogOut);
    on<AuthenticationEventInital>(_authenticationEventInital);
    on<AuthenticationEventGetMe>(_authenticationEventGetMe);

  }

  _authenticationEventGetMe(AuthenticationEventGetMe event, Emitter<AuthenticationState> emit) async {
    debugPrint("_authenticationEventGetMe");
    final Account account = await authenticationRepository.getMe();
    if (account.username != 'quest') {
      emit(AuthenticationStateAuthTrue(account: account));
    }
    //debugPrint(account.toString());
  }

  _authenticationEventInital(AuthenticationEventInital event, Emitter<AuthenticationState> emit) async {
    debugPrint("_authenticationEventInital");
      final User? user = FirebaseAuth.instance.currentUser;

      if (user is User) {
          if (user.refreshToken != null) {
              debugPrint("refreshToken:Not null");
              debugPrint("!!!!!!USER: ${user.toString()}");
              final String token = await authenticationRepository.signInWithRefreshToken(user.refreshToken.toString());
              if (token.isNotEmpty) {
                authenticationRepository.setToken(token);
                final Account account = await authenticationRepository.getMe();
                if (account.id=='0') {
                  return emit(AuthenticationStateLogOut());
                }
                return emit(AuthenticationStateAuthTrue(account: account));      
              }
             // 
          } else {
            debugPrint("refreshToken:null  Token: ${user.refreshToken.toString()}");
            //final Account account = await authenticationRepository.getMe();
            //debugPrint(FirebaseAuth.instance.currentUser.toString());
          }
          //
          
          final Account account = await authenticationRepository.getMe();
          debugPrint("==========Account");
          debugPrint(account.toString());
          if (account.id != '0') {
              return emit(AuthenticationStateAuthTrue(account: account));
          }
      }

    return emit(AuthenticationStateLogOut());
  }

  _authenticationEventLogIn(AuthenticationEventLogIn event, Emitter<AuthenticationState> emit) async {
    debugPrint("_authenticationEventLogIn ");
    debugPrint(event.usrname);
    debugPrint(event.password);
    final Account account = await authenticationRepository.logIn(event.usrname, event.password);
    debugPrint(account.toString());
    //debugPrint(authenticationRepository.getToken());

    if (account.username != 'guest' ) {
      try {
        
          UserCredential userCredential = await FirebaseAuth.instance.signInWithCustomToken(authenticationRepository.getToken());
          debugPrint("userCredential.user.toString()");
          debugPrint(userCredential.user.toString());
          return emit(AuthenticationStateAuthTrue(account: account));
      } catch (e) {
        debugPrint(e.toString());
      }
      
    } else {
      return emit(AuthenticationStateLogOut());
    }
  }

  _authenticationEventCheckToken(AuthenticationEventCheckToken event, Emitter<AuthenticationState> emit) async {
    debugPrint("_authenticationEventCheckToken");

  }

  _authenticationEventLogOut(AuthenticationEventLogOut event, Emitter<AuthenticationState> emit) async {
    debugPrint("_authenticationEventLogOut");
    await FirebaseAuth.instance.signOut().then((value){
      emit(AuthenticationStateLogOut());
    });
    
  }

}
