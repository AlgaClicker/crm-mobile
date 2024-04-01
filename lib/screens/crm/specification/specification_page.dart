import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_alga_crm/domain/entity/account/account.dart';
import 'package:mobile_alga_crm/domain/entity/crm/specification.dart';
import 'package:mobile_alga_crm/helpers/api_client.dart';
import 'package:mobile_alga_crm/repository/crm/specification_repository.dart';
import 'package:mobile_alga_crm/screens/crm/specification/bloc/specification_page_bloc.dart';

class SpecificationPage extends StatelessWidget {
  final ApiClient apiClient;
  const SpecificationPage({super.key, required this.apiClient});
  
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Спецификации'),
      ),
      body: SpecificationPageBiuilding(apiClient: apiClient,),
      persistentFooterAlignment: AlignmentDirectional.bottomCenter,
      persistentFooterButtons: [
          IconButton(
            onPressed: ()=>{}, 
            icon: const Icon(Icons.extension_off_outlined)
          ),
          TextButton(
            onPressed: ()=> context.go('/'), 
            child: const Text('Главная')
          ),
      ],

    );
  }
}


class SpecificationPageBiuilding extends StatelessWidget {
  final ApiClient apiClient;
  
  const SpecificationPageBiuilding({super.key, required this.apiClient});
  @override

  Widget build(BuildContext context) {
    final specificationRepository = SpecificationRepository(api: apiClient);
      return BlocProvider<SpecificationPageBloc>(
        create: (_) => SpecificationPageBloc(specificationRepository),
        child: BlocBuilder<SpecificationPageBloc,SpecificationPageBlocState>(
          builder: (context, state) {
            if (state is SpecificationPageBlocStateInitial) {
               context.read<SpecificationPageBloc>().add(SpecificationPageBlocEventInital());
            }
            return SpecificationList();
          }
        ),
      );
  }
}



class SpecificationList extends StatelessWidget {
 const SpecificationList({super.key});
  
  
  @override
  Widget build(BuildContext context) {
        final SpecificationPageBloc pageBloc = context.read<SpecificationPageBloc>();
        if (pageBloc.state is SpecificationPageBlocStateLoadedSpecifictionList) {
          final List<Specification> specifications = context.read<SpecificationPageBloc>().state.specifications;
          return DataList(dataList: specifications);
        }
        if (pageBloc.state is SpecificationPageBlocStateLoadSpec) {
            return const Center(child: CircularProgressIndicator());
        }

        return Column(
          children: [
             const Text("Spec lixt"),
             Text(pageBloc.state.toString()), 
             if (pageBloc.state is SpecificationPageBlocStateLoadedSpecifictionList)
              Text(pageBloc.state.toString()),

          ],
        );

  }
}


class DataList extends StatelessWidget {
  final List<Specification> dataList;

  const DataList({super.key,required this.dataList});

  @override
  Widget build(BuildContext context) {
    debugPrint("ListView.builder countItems: ${dataList.length.toString()}");
    
    return Expanded(
      child:  _buildList(context),
    );
    
    
  }



  ListView _buildList(context){
    
    return ListView.builder(
      
      itemCount: dataList.length,
      itemBuilder: (context,index){
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const SizedBox(height: 10,),
              Material(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                      side: const BorderSide(color: Colors.blueAccent),
                    ),
                  child: ViewSpec(specification: dataList[index],),
                ),
                            
          ]);
      });
  }
}

class ViewSpec extends StatelessWidget {
  final Specification specification;
  
  const ViewSpec({super.key,required this.specification});
  
 @override
 Widget build(BuildContext context) {
  final List<Account> responsibles = List<Account>.from(specification.responsibles as List<Account>);
  debugPrint(responsibles.toString());
  return ExpansionTile(
    title: Column(
      children: [
        Text("${specification.name}; ${specification.objectName}"),
        Text("от ${specification.createdAt?.day}/${specification.createdAt?.month}/${specification.createdAt?.year}"),
      ],
    ),
    children: [
      Card(
        
        child: Column(
          children: [
            const Text("Ответственные"),
            WidgetListResponsiblesBUldList(responsibles: responsibles)
          ],
        ),
      ),
    ],
  );
 }
}

class WidgetListResponsiblesBUldList extends StatelessWidget {
  final List<Account> responsibles;
  const WidgetListResponsiblesBUldList({super.key,required this.responsibles});
  @override
    Widget build(BuildContext context) {
      return _buildList(context);
    }

    _buildList(BuildContext context) {

      return  ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: responsibles.length,
          itemBuilder: (context,index){
            //return WidgetResponsible(responsible: responsibles[index]);
            return WidgetResponsible(responsible: responsibles[index],);
      });
    }
}


class WidgetResponsible extends StatelessWidget {
  final Account responsible;
  const WidgetResponsible({super.key,required this.responsible});
  @override
  
    Widget build(BuildContext context) {
        return Row(
          children: [
            TextButton(
              onPressed: ()=>context.go('/account/${responsible.id}'), 
              child: Text("Пользователь: ${responsible.username}")
            ),
            
            if(responsible.workpeople != null) 
              Text("ФИО: ${responsible.workpeople?.name} ${responsible.workpeople?.surname} ${responsible.workpeople?.patronymic}")
          ],
        );
    }
}

class WidgetListResponsibles extends StatelessWidget {
  final List<Account> responsibles;
  const WidgetListResponsibles({super.key,required this.responsibles});
  @override
  
    Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: responsibles.length,

      itemBuilder: (context, index) {
        debugPrint("responsible index: ${index.toString()}");
        return ListTile(
          title: Text(responsibles[index].username),
        );
      }
    );
  }
}