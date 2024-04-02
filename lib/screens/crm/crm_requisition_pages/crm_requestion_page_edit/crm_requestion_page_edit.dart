import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mobile_alga_crm/screens/crm/crm_requisition_pages/crm_requestion_page_edit/bloc/crm_requestion_page_edit_bloc.dart';



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

class RequisitionEndAtWidget extends StatelessWidget {
  final DateTime endAt;
  const RequisitionEndAtWidget({super.key, required this.endAt});

  
  @override
  Widget build(BuildContext context) {
    final String endAtText = DateFormat('dd/MM/yyyy').format(endAt);
    return TextFormField(
      controller: TextEditingController(text: endAtText),
      onTap: () => _selecetDateEnd(context),
      readOnly: true,
      decoration: const InputDecoration(
        labelText: 'До какой даты поставить',
        prefixIcon: Icon(Icons.calendar_today_outlined),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 2, 
            color: Color.fromARGB(255, 105, 118, 240)
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 2, 
            color: Color.fromARGB(255, 105, 118, 240)
          ),
        )
      ),
    );
  }
  
  Future<void> _selecetDateEnd(BuildContext context) async {
     DateTime? _picked = await showDatePicker(
      helpText: 'До какой даты поставить',
      initialDate: DateTime.now().add(const Duration(days: 1)),
      context: context, 
      firstDate: DateTime.now().add(const Duration(days: 1)), 
      lastDate:  DateTime.now().add(const Duration(days: 365)),
      
    );
    debugPrint("date: ${_picked.toString()} Type Picker: ${_picked.runtimeType}");
     if (_picked != null) {
        context.read<CrmRequestionPageEditBloc>().add(CrmRequestionPageEditEventSelectEndDate(endAt: _picked));
     } 
  }
}


class CrmRequisitionPagesEditScaffoldBody extends StatelessWidget {
    final CrmRequestionPageEditState state;
    const CrmRequisitionPagesEditScaffoldBody({super.key, required this.state});

  
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
              RequisitionEndAtWidget(endAt: state.endAt,)
            ]
          ,)
        ),
      );
  }
}

