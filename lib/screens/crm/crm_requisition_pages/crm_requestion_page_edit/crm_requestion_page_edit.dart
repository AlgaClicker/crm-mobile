import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mobile_alga_crm/screens/crm/crm_requisition_pages/crm_requestion_page_edit/bloc/crm_requestion_page_edit_bloc.dart';
import 'package:mobile_alga_crm/screens/widgets/requestion/requisition_end_at_widget.dart';



class CrmRequisitionPagesEdit extends StatelessWidget {
  const CrmRequisitionPagesEdit({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Новая заявка"),
      ),
      body: const CrmRequisitionPagesEditBuildBloc()
    
    );
  }
}

class CrmRequisitionPagesEditBuildBloc extends StatelessWidget {
  const CrmRequisitionPagesEditBuildBloc({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider<CrmRequestionPageEditBloc>(
      create: (_)=>CrmRequestionPageEditBloc(),
      child: BlocBuilder<CrmRequestionPageEditBloc,CrmRequestionPageEditState>(
        builder: (context, state) {
          return CrmRequisitionPagesEditScaffoldBody(state: state,);
        },
      ),
    );
  }
}




class CrmRequisitionPagesEditScaffoldBody extends StatelessWidget {
    final CrmRequestionPageEditState state;
    const CrmRequisitionPagesEditScaffoldBody({super.key, required this.state});

  void _selestDateEndAt(endAt) {
    debugPrint("_selestDateEndAt ${endAt.toString()}");
  }
  
  @override
  Widget build(BuildContext context) {
    final CrmRequestionPageEditBloc bloc = context.read<CrmRequestionPageEditBloc>();
    
    final String endAtText = DateFormat('dd/MM/yyyy').format(state.endAt);
    debugPrint("CrmRequisitionPagesEditScaffoldBody endAt: ${bloc.state.endAt} endAtText:${endAtText}");
    return Padding(
        padding: const EdgeInsets.all(10),
        child: Form(
          child: Column(
            children: [
              Text(bloc.state.toString()),
              RequisitionEndAtWidget(endAt: state.endAt,onChange: _selestDateEndAt,)
            ]
          ,)
        ),
      );
  }
}

