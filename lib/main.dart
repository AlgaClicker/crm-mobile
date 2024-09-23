import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/Utils/dio_client.dart';
import 'package:mobile_app/BLoC/AuthBloc/auth_bloc.dart';
import 'package:mobile_app/Services/auth_service.dart';
import 'package:mobile_app/Screens/login_page.dart';
import 'package:mobile_app/Screens/master_page.dart';
import 'package:mobile_app/Screens/supply_page.dart';
import 'package:mobile_app/Screens/upravlenie_page.dart';
import 'package:mobile_app/Screens/master/master_requisitions_page.dart';
import 'package:mobile_app/Screens/master/master_teams_page.dart';
import 'package:mobile_app/Screens/master/master_specifications_page.dart';
import 'package:mobile_app/Repositories/master_requisitions_repository.dart';
import 'package:mobile_app/Screens/master/CreateRequisitionPage/master_create_requisition_page .dart';
import 'package:mobile_app/Screens/master/CreateRequisitionPage/create_page_requisition_bloc.dart';
import 'package:mobile_app/Repositories/master_specifications_repository.dart';
import 'package:mobile_app/bloc/Specifications/specifications_bloc.dart';
import 'package:mobile_app/Screens/master/Specification/master_specifications_page_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Инициализация Flutter
  await initializeDateFormatting('ru', null);
  final DioClient dioClient = DioClient();
  final authService = AuthService(dio: dioClient.dio);
  

  await authService.initialize(); // Инициализация AuthService с проверкой токена
  runApp(MyApp(dioClient: dioClient, authService: authService));

}

class MyApp extends StatelessWidget {
  final DioClient dioClient;
  final AuthService authService;
  
  MyApp({required this.dioClient, required this.authService});

  @override
  Widget build(BuildContext context) {
    final masterSpecificationsRepository = MasterSpecificationsRepository(dioClient.dio);
    final masterRequisitionsRepository =
        MasterRequisitionsRepository(dioClient.dio);
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              AuthBloc(dioClient: dioClient, authService: authService),
        ),
        BlocProvider(
          create: (context) =>
              SpecificationsBloc(repository: masterSpecificationsRepository),
        ),
      ],
      child: MaterialApp(
        title: 'Alga Business Management',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: {
          '/login': (context) => LoginPage(),
          '/master': (context) => MasterPage(),
          '/master/requisitions': (context) => MasterRequisitionsPage(
              masterRequisitionsRepository: masterRequisitionsRepository),
          '/master/teams': (context) => MasterTeamsPage(),
          '/master/specifications': (context) => BlocProvider(
              create: (context) => MasterSpecificationsPageBloc(
                masterSpecificationsRepository: masterSpecificationsRepository,
              ),
              child: MasterSpecificationsPage(),
            ),
          // Добавляем маршрут для создания заявки
          '/master/requisition/new': (context) => BlocProvider(
                create: (context) => MasterPageRequisitionBloc(
                    requisitionRepository: masterRequisitionsRepository),
                child: CreateRequisitionPage(),
              ),
          '/supply': (context) => SupplyPage(),
          '/upravlenie': (context) => UpravleniePage(),
        },

        home: SplashScreen(), // Переход к SplashScreen
      ),
    );
  }
}

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthInitial) {
          return LoginPage();
        } else if (state is AuthSuccess) {
          final roleService = state.authToken.account.role.service;
          switch (roleService) {
            case 'master':
              return MasterPage();
            case 'snabzenie':
              return SupplyPage();
            case 'upravlenie':
              return UpravleniePage();
            default:
              return LoginPage(); // fallback case
          }
        } else if (state is AuthFailure) {
          return LoginPage(errorMessage: state.message);
        } else {
          return const Scaffold(
              body: Center(child: CircularProgressIndicator()));
        }
      },
    );
  }
}
