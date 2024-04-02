import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mobile_alga_crm/repository/crm/requisition_repository.dart';
import 'package:mobile_alga_crm/screens/crm/crm_requisition_pages/crm_requestion_page_only/bloc/crm_requestion_page_only_bloc.dart';

class CrmRequestionpageOnly extends StatelessWidget {
  final RequisitionRepository requisitionRepository;
  final String idRequisition;
  const CrmRequestionpageOnly({super.key, required this.requisitionRepository, required this.idRequisition});
  @override
  Widget build(BuildContext context) {
    
    return BlocProvider(
      
      create: (_)=>CrmRequestionPageOnlyBloc(requisitionRepository),
      child: CrmRequestionpageOnlyBuild(idRequisition: idRequisition),
    );
  }
}

class CrmRequestionpageOnlyBuild extends StatelessWidget {
  final String idRequisition;
  const CrmRequestionpageOnlyBuild({super.key, required this.idRequisition});

  @override
  Widget build(BuildContext context) {
    String idReg = idRequisition;
    return BlocBuilder<CrmRequestionPageOnlyBloc,CrmRequestionPageOnlyState>(
      builder: (context, state){
        if (state is CrmRequestionPageOnlyStateInitial) {
          context.read<CrmRequestionPageOnlyBloc>().add(CrmRequestionPageOnlyEventInital(idRequestion: idReg));
        }

        if (state is CrmRequestionPageOnlyStateLoaded) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Заявка ${state.requisition.number} до ${DateFormat('dd/MM/yy').format(state.requisition.endAt)}"),
            ),
            body: Center(
              child: Column(
                children: [
                  Text(state.requisition.manager.toString())
                ],
              ),
            ),
          );
        }

        return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                   CircularProgressIndicator(),
                ],
              ),
            );
      }
    );
  }
}

