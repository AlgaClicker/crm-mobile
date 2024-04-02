import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:mobile_alga_crm/domain/entity/crm/requisition.dart';
import 'package:mobile_alga_crm/helpers/api_client.dart';
import 'package:mobile_alga_crm/repository/crm/requisition_repository.dart';
import 'package:mobile_alga_crm/screens/crm/crm_index_page/bloc/crm_index_page_bloc.dart';
import 'package:mobile_alga_crm/screens/crm/crm_requisition_pages/bloc/crm_requisition_pages_bloc.dart';


class CrmRequisitionPages extends StatelessWidget {
  final ApiClient apiClient;
  const CrmRequisitionPages({super.key, required this.apiClient});
  @override
  Widget build(BuildContext context) {
    final RequisitionRepository requisitionRepository = RequisitionRepository(api: apiClient);
    return RepositoryProvider(
      create: (context) => requisitionRepository,
      child: BlocProvider(
        create: (_) => CrmRequisitionPagesBloc(requisitionRepository),
        child: const _CrmRequisitionPages(),
      )
    );
  }
}

class _CrmRequisitionPagesBuild extends StatelessWidget {
  const _CrmRequisitionPagesBuild();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CrmRequisitionPagesBloc,CrmRequisitionPagesState>(
      builder:(context, state) {
        context.read<CrmRequisitionPagesBloc>().add(CrmRequisitionPageEventInital());
        return const _CrmRequisitionPages();
      },
      
    );
  }
}



class _CrmRequisitionPages extends StatelessWidget {
  const _CrmRequisitionPages();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Заявки'),
        centerTitle: false,
        actions: [
          InkWell(
            onTap: ()=>{},
            child: const SizedBox(width: 40,child: Icon(Icons.local_activity_rounded),)
          )
        ],
      ),
      body: const _CrmRequisitionPageScaffoldBody(),
      persistentFooterAlignment: AlignmentDirectional.bottomStart,
      
      persistentFooterButtons: [
          IconButton(
            onPressed: ()=>{}, 
            icon: const Icon(Icons.handyman)
          ),
          TextButton(
            onPressed: ()=>context.read<CrmIndexPageBloc>().add(CrmIndexPageEventInital()), 
            child: const Text('Главная')
          ),
          TextButton(
            onPressed: ()=>{}, 
            child: const Text('У менеджера')
          ),
          TextButton(
            onPressed: ()=>context.read<CrmRequisitionPagesBloc>().add(CrmRequisitionPageEventLoadRequisitions()), 
            child: const Text('полный список')
          ),
          TextButton(
            onPressed: ()=>{}, 
            child: const Text('Новая')
          ),


      ],
    );
  }
}




class _CrmRequisitionPageScaffoldBody extends StatelessWidget {
  const _CrmRequisitionPageScaffoldBody();
    @override
  Widget build(BuildContext context) {
    context.read<CrmRequisitionPagesBloc>().add(CrmRequisitionPageEventInital());

    return Container(
      alignment: Alignment.topCenter,
      child: BlocBuilder<CrmRequisitionPagesBloc,CrmRequisitionPagesState>(
        builder: (context,state) {
          if (state is CrmRequisitionPagesStateLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is CrmRequisitionPagesStateLoadList) {
            return _CrmRequisitionWidgetList(requisitions: state.requisitions);
          }
          if (state is CrmRequisitionPagesInitial) {
            return const Text("Виджет главной страницы");
          }

          return Text(context.read<CrmRequisitionPagesBloc>().state.toString());
        },
      ),
    );
  }
}


class _CrmRequisitionWidgetList extends StatelessWidget {
  final List<Requisition> requisitions;
  const _CrmRequisitionWidgetList({required this.requisitions});
      @override
  Widget build(BuildContext context) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: ListView.builder(
          itemCount: requisitions.length,
          itemBuilder: (context,index) {
            
            final Requisition requisition = requisitions[index];
            return InkWell(
              onTap: (){
                context.go('/requestion/${requisition.id}');
              },
              child: _CrmRequisitionWidget(requisition: requisition),
            );
          }
        ),
      );
  }
}


class _CrmRequisitionWidget extends StatelessWidget {
  final Requisition requisition;
  const _CrmRequisitionWidget({required this.requisition});
  @override
  Widget build(BuildContext context) { 
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 10
        ),
        child: Column(
          children: [
            Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  const Text(
                    "Заявка ",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.normal
                    ),
                  ),
                  Text(
                    requisition.number,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text("поставить до ${DateFormat('dd/MM/yyyy').format(requisition.endAt)}"),
                  const Text(" Статус:"),
                  Text(
                    requisition.status,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  if (requisition.status == "manage")
                  Row(
                    children: [
                      const Text(
                        "Менеджер:",
                        style: TextStyle(
                          color: Colors.indigo,
                          fontSize: 12,
                          fontWeight: FontWeight.bold
                        ),                    
                      ),
                      Text(
                        requisition.manager!.username,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold
                        ),
                      )
                    ],
                  ),
                  Text(
                    " Спецификация ${requisition.specification!.name}",
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold
                    ),                    
                  ),
                ],
              ),
              if (requisition.description.toString().isNotEmpty != true )
                Text("Коментарий: ${requisition.description}"),

            
          ],
        ),
      ),
    );
  }
}