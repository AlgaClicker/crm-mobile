import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_alga_crm/bloc/application_bloc/application_bloc.dart';
import 'package:mobile_alga_crm/bloc/authentication_bloc/authentication_bloc.dart';

import 'package:mobile_alga_crm/helpers/api_client.dart';
import 'package:mobile_alga_crm/repository/systems/authentication_repository.dart';
import 'package:mobile_alga_crm/screens/crm/crm_index_page/crm_index_page.dart';
import 'package:mobile_alga_crm/screens/login_page/logon_page.dart';
import 'firebase_options.dart';


final ApiClient _apiClient = ApiClient();

final  AuthenticationRepository authenticationRepository = AuthenticationRepository(_apiClient);
final  AuthenticationBloc _authenticationBloc = AuthenticationBloc(authenticationRepository: authenticationRepository);
final ApplicationBloc _applicationBloc = ApplicationBloc(_authenticationBloc);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  //await FirebaseAuth.instance.useAuthEmulator('127.0.0.1', 9099);

  _apiClient.initClient('http://192.168.0.210:8888/');
  
  runApp(const CrmAlgaApp());
}
 


class CrmAlgaApp extends StatelessWidget {
  const CrmAlgaApp({super.key});
  @override
  
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context)=>_applicationBloc
        ),
        RepositoryProvider.value(
          value: authenticationRepository,
          child: BlocProvider(
            create: (_) => _authenticationBloc,
          ),
        ),
      ], 
      child: CrmAlgaAppInstanceBuildTest(authenticationBloc: _authenticationBloc)
  );
  }
}


class CrmAlgaAppInstanceBuildTest extends StatelessWidget {
final AuthenticationBloc authenticationBloc;
 const  CrmAlgaAppInstanceBuildTest({super.key, required this.authenticationBloc});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => _applicationBloc
        ),
        BlocProvider(
          create: (BuildContext context) => _authenticationBloc
        ),
      ], 
      child: const CrmAlgaApplicationListener()
    );
  }
}

class CrmAlgaApplicationListener extends StatelessWidget {
  const CrmAlgaApplicationListener({super.key});
  @override
  Widget build(BuildContext context) {
      return BlocListener<ApplicationBloc,ApplicationBlocState>(
        listener: (context, state) {
            debugPrint("BlocListener<ApplicationBloc,ApplicationBlocState>");  
            if (state is ApplicationBlocInitial) {
              context.read<ApplicationBloc>().add(ApplicationBlocEventInit());
            }


            
        },
        child: const CrmAlgaAppAuthListener(),
      );
  }
}

class CrmAlgaAppAuthListener extends StatelessWidget {
  const CrmAlgaAppAuthListener({super.key});
  @override
  Widget build(BuildContext context) {
    
    return MultiBlocListener(
      listeners: [
          BlocListener<AuthenticationBloc,AuthenticationState>(
            listener: (context,state) {
              if (state is AuthenticationStateAuthTrue) {
                context.read<ApplicationBloc>().add(ApplicationBlocEventAuth(account: state.account));
              }
              if (state is AuthenticationStateLogOut) {
                //debugPrint("BlocListener<AuthenticationBloc,AuthenticationState> : AuthenticationStateLogOut");
                context.read<ApplicationBloc>().add(ApplicationBlocEventNoAuth());
              }
            }
          ),
          BlocListener<ApplicationBloc,ApplicationBlocState>(
            listener: (context, state) {

            },
          )
      ], 
      child: const CrmAlgaAppBuldinerAppAuth(),
    );
  }
}


class CrmAlgaAppBuldinerAppAuth extends StatelessWidget {
  
  const CrmAlgaAppBuldinerAppAuth({super.key});
  @override
  Widget build(BuildContext context) {
    context.read<ApplicationBloc>().add(ApplicationBlocEventInit());
    return BlocBuilder<ApplicationBloc,ApplicationBlocState>(
      builder:  (context, state) {
        //debugPrint("========CrmAlgaAppBuldinerAppAuth state");
        //debugPrint(state.toString());

        if (state is ApplicationBlocStateAuth) {
            return CrmIndexPage(apiClient: _apiClient, applicationBloc: _applicationBloc, authenticationBloc: _authenticationBloc);
        }   
        if (state is ApplicationBlocStateNoAuth) {
          return const LoginPage();
        }
        
        if (state is AuthenticationStateLogOut) {
          return const LoginPage();
        }

        return MaterialApp(
          home: Scaffold(
            appBar: AppBar(
              title: const Text('Инициализация'),
              centerTitle: true,
            ),
            body: const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                   CircularProgressIndicator(),
                ],
              ),
            ),
          ),
        );
      }
    );
  }
}


class CrmAlgaAppMaterialApp extends StatelessWidget {
  const CrmAlgaAppMaterialApp({super.key});
  @override
  Widget build(BuildContext context) {
    context.read<ApplicationBloc>().add(ApplicationBlocEventInit());
    
    return MaterialApp(
      title: 'Crm Alga Material App Widget',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ).copyWith(background: Colors.grey[850]!),
      ),
      home: BlocBuilder<ApplicationBloc,ApplicationBlocState>(
        builder: (context, state){

          if (state is ApplicationBlocStateNoAuth) {
            return const LoginPage();
          }

          return Scaffold(
            body: Center(
              child: Column(
                children: [
                  //Text(context.read<ApplicationBloc>().state.toString()),
                  Text(context.read<AuthenticationBloc>().state.toString()),
                ],
              ),
            ),

            floatingActionButton: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,

              children: [
                IconButton(
                  onPressed: ()=>context.read<ApplicationBloc>().add(ApplicationBlocEventInit()), 
                  icon: const Icon(Icons.event_busy)
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class CrmAlgaAppInstanceListener1 extends StatelessWidget {
  const CrmAlgaAppInstanceListener1({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AuthenticationBloc,AuthenticationState>(listener: (context, state) {
          if (state is AuthenticationInitial) {

          }
          
          debugPrint('BlocListener<AuthenticationBloc,AuthenticationState>');
        }),
        BlocListener<ApplicationBloc,ApplicationBlocState>(listener: (context, state){
          if (state is ApplicationBlocInitial) {
              debugPrint('BlocListener<ApplicationBloc,ApplicationBlocState>');
          }

          debugPrint('BlocListener<ApplicationBloc,ApplicationBlocState>');
        }), 
      ], 
      child: const CrmAlgaAppMaterialApp()
    );
  }
} 


class CrmAlgaAppInstanceBuilder extends StatelessWidget {
  const CrmAlgaAppInstanceBuilder({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc,AuthenticationState>(
      builder: (context, state) {
        debugPrint("BlocBuilder<AuthenticationBloc,AuthenticationState>");
        debugPrint(state.toString());
        return const Text("CrmAlgaAppInstanceBuilder");
      }
    );
  }
}



