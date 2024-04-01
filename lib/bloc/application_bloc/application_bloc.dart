
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_alga_crm/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:mobile_alga_crm/domain/entity/account/account.dart';
part 'application_bloc_event.dart';
part 'application_bloc_state.dart';



class ApplicationBloc extends Bloc<ApplicationBlocEvent, ApplicationBlocState> {
  late final AuthenticationBloc _authenticationBloc;
  ApplicationBloc(AuthenticationBloc authenticationBloc) : _authenticationBloc = authenticationBloc,super(ApplicationBlocInitial()) {
    on<ApplicationBlocEventInit>(_applicationBlocEventInit);
    on<ApplicationBlocEventAuth>(_applicationBlocEventAuth);

    on<ApplicationBlocEventNoAuth>(_applicationBlocEventNoAuth);
    
    
    
  }

  _applicationBlocEventNoAuth(ApplicationBlocEventNoAuth e, Emitter<ApplicationBlocState> emit) {
    emit(ApplicationBlocStateNoAuth());
  }

  _applicationBlocEventAuth(ApplicationBlocEventAuth e, Emitter<ApplicationBlocState> emit) {
    debugPrint('_applicationBlocEventAuth');
    emit(ApplicationBlocStateAuth(account: e.account));
  }

  _applicationBlocEventInit(ApplicationBlocEventInit e, Emitter<ApplicationBlocState> emit) {
    debugPrint('_applicationBlocEventInit');
    _authenticationBloc.add(AuthenticationEventInital());
  }
}
