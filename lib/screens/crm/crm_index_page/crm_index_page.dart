import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mobile_alga_crm/bloc/application_bloc/application_bloc.dart';
import 'package:mobile_alga_crm/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:mobile_alga_crm/helpers/api_client.dart';
import 'package:mobile_alga_crm/repository/crm/requisition_repository.dart';
import 'package:mobile_alga_crm/repository/crm/specification_repository.dart';
import 'package:mobile_alga_crm/screens/crm/crm_index_page/bloc/crm_index_page_bloc.dart';
import 'package:mobile_alga_crm/screens/crm/crm_requisition_pages/crm_requestion_page_edit/crm_requestion_page_edit.dart';
import 'package:mobile_alga_crm/screens/crm/crm_requisition_pages/crm_requestion_page_only/crm_requestion_page_only.dart';
import 'package:mobile_alga_crm/screens/crm/crm_requisition_pages/crm_requisition_pages.dart';
import 'package:mobile_alga_crm/screens/crm/specification/specification_page.dart';
import 'package:go_router/go_router.dart';


class CrmIndexPage extends StatelessWidget {
    final ApplicationBloc applicationBloc;
    final ApiClient apiClient;
    final AuthenticationBloc  authenticationBloc;
    const CrmIndexPage({
      super.key, 
      required this.apiClient,
      required this.applicationBloc,
      required this.authenticationBloc 
    });
      @override
        Widget build(BuildContext context) {
          final specificationRepository = SpecificationRepository(api: apiClient);
          return BlocProvider<CrmIndexPageBloc>(
            create: (_)=>CrmIndexPageBloc(
              specificationRepository: specificationRepository
            ),
            child: CrmIndexPageBuilder(apiClient: apiClient,),
          );
        }
}

class CrmIndexPageBuilder extends StatelessWidget {
  final ApiClient apiClient;
    const CrmIndexPageBuilder({super.key, required this.apiClient});
      
      @override
      
        Widget build(BuildContext context) {
          final _router = Router(apiClient: apiClient);
          return BlocBuilder<CrmIndexPageBloc,CrmIndexPageState>(
            builder: (context,state) {
              debugPrint(context.read<ApplicationBloc>().state.account.toString());
              debugPrint(state.toString());
                return MaterialApp.router(
                  title: 'CMS Алга',
                  debugShowCheckedModeBanner: false,
                  routerConfig:   GoRouter(
                    routes: _router.listRoutes()
                  ),
                localizationsDelegates: const [
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: const [
                  Locale('ru','RU'),
                ]
                );
            },
          );
        }
}


class Router {
  late final ApiClient apiClient;
  
  Router({required this.apiClient});


   listRoutes() {
    final RequisitionRepository requisitionRepository = RequisitionRepository(api: apiClient);
    return [
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return const _CrmIndexScreen();
        },
        routes: [
          GoRoute(
            path: 'requestion',
                      builder: (BuildContext context, GoRouterState state) {
                return CrmRequisitionPages(apiClient: apiClient,);
              },
              routes: [
              GoRoute(
                path: 'new',
                    builder: (BuildContext context, GoRouterState state) {
                      debugPrint("Router requestion/new");
                    return const CrmRequisitionPagesEdit();
                  },
                
              ),

                GoRoute(
                path: ':id',
                    builder: (BuildContext context, GoRouterState state) {
                    return CrmRequestionpageOnly(
                      requisitionRepository: requisitionRepository, 
                      idRequisition: state.pathParameters['id'].toString()
                    );
                  },
                
              ),

              ]
          ),


          GoRoute(
            path: 'specification',
                      builder: (BuildContext context, GoRouterState state) {
                return SpecificationPage(apiClient: apiClient);
              },
          ),

        ]
      ),

    ];
  }
}



class _CrmIndexScreen  extends StatelessWidget {
  const _CrmIndexScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Text("_CrmIndexScreen"),
      persistentFooterAlignment: AlignmentDirectional.bottomCenter,
      persistentFooterButtons: [
        ElevatedButton.icon(
          onPressed: () => context.go('/requestion'), 
          icon: const  Icon(Icons.format_list_bulleted), 
          label: const Text('Заявки')
        ),
        ElevatedButton.icon(
          onPressed: () => context.go('/specification'), 
          icon: const  Icon(Icons.folder_special), 
          label: const Text('Спецификации')
        ),

        ElevatedButton.icon(
          onPressed: () => context.go('/requestion'), 
          icon: const  Icon(Icons.exit_to_app), 
          label: const Text('Выход')
        ),

      ],
    );
  }

}





class _CrmIndexPage extends StatelessWidget {
  const _CrmIndexPage({super.key});
  @override
  
  Widget build(BuildContext context) {
  final authenticationBlocState = context.read<AuthenticationBloc>().state;   
      
    if (authenticationBlocState is AuthenticationStateAuthTrue) {
      final account = authenticationBlocState.account;
      return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              useMaterial3: true,
               primaryColor: Colors.green,
               
            ),
            home: Scaffold(
              appBar: AppBar(
                title: Row(
                  children: [
                    Text("Пользователь: ${account.username}")
                  ],
                ),
                centerTitle: true,
              ),
              
              body: const Center(
                child: Column(
                  children: [
                    Text(
                      'CrmIndexPagePage is working',
                      style: TextStyle(fontSize: 20),
                    ),
                    Text("test"),
                  ],
                ),

              ),
              persistentFooterAlignment: AlignmentDirectional.bottomCenter,
              persistentFooterButtons: [
                  TextButton(
                    onPressed: ()=> context.read<CrmIndexPageBloc>().add(CrmIndexPageEventListSpec()), 
                    child: const Text('Спецификации')
                  ),
                  TextButton(
                    onPressed: ()=> context.read<CrmIndexPageBloc>().add(CrmIndexPageEventListRequestions()), 
                    child: const Text('Заявки')
                  ),
                  IconButton(
                    onPressed: ()=>{}, 
                    icon: const Icon(Icons.logout)
                  ),
              ],
              
            ),
          );
    } else {
      return const MaterialApp(
        home: Center(child: Text("Init"),),
      );
    } 
  }
}


