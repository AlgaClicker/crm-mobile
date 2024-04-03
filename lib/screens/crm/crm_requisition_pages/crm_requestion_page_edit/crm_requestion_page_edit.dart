
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mobile_alga_crm/domain/entity/crm/specification_material.dart';
import 'package:mobile_alga_crm/repository/crm/requisition_repository.dart';
import 'package:mobile_alga_crm/repository/crm/specification_repository.dart';
import 'package:mobile_alga_crm/screens/crm/crm_requisition_pages/crm_requestion_page_edit/bloc/crm_requestion_page_edit_bloc.dart';
import 'package:mobile_alga_crm/screens/widgets/requestion/requisition_end_at_widget.dart';
import 'package:mobile_alga_crm/screens/widgets/requestion/requisition_select_spec.dart';
import 'package:pluto_grid/pluto_grid.dart';



class CrmRequisitionPagesEdit extends StatelessWidget {
  final RequisitionRepository requisitionRepository;
  final SpecificationRepository specificationRepository;
  const CrmRequisitionPagesEdit({super.key, required this.requisitionRepository, required this.specificationRepository});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Новая заявка"),
      ),
      body: BlocProvider<CrmRequestionPageEditBloc>(
      create: (_)=>CrmRequestionPageEditBloc(requisitionRepository,specificationRepository),
      child: BlocBuilder<CrmRequestionPageEditBloc,CrmRequestionPageEditState>(
        builder: (context, state) {
          debugPrint("state.specifications.length : ${state.specifications.length.toString()} state:${state.toString()}");
          if (state is CrmRequestionPageEditStateInitial) {
              context.read<CrmRequestionPageEditBloc>().add(CrmRequestionPageEditEventLoadListSpecifications());
          }
          //context.read<CrmRequestionPageEditBloc>().add(CrmRequestionPageEditEventLoadListSpecifications());
          return CrmRequisitionPagesEditScaffoldBody();
        },
      ),
    )
    
    );
  }
}




class CrmRequisitionPagesEditScaffoldBody extends StatelessWidget {
  const CrmRequisitionPagesEditScaffoldBody({super.key});
  @override

  Widget build(BuildContext context) {
    final CrmRequestionPageEditBloc bloc = context.read<CrmRequestionPageEditBloc>();

    Future<void> _selestDateEndAt(DateTime endAt) async {
      debugPrint("_selestDateEndAt ${endAt.toString()}");
      context.read<CrmRequestionPageEditBloc>().add(CrmRequestionPageEditEventSelectEndDate(endAt: endAt));
    }
    Future<void> _selectedSpecification(String specificationId) async {
      debugPrint("_selectedSpecification  specificationId:$specificationId");
      context.read<CrmRequestionPageEditBloc>().add(CrmRequestionPageEditEventSelectedSpecification(specificationId: specificationId));
    }

    if (bloc.state is CrmRequestionPageEditStateWorking ) {
  //        specifications = bloc.state.specifications ;
    } 
    
    final String endAtText = DateFormat('dd/MM/yyyy').format(bloc.state.endAt);
    debugPrint("CrmRequisitionPagesEditScaffoldBody SpecCount: ${bloc.state.specifications} endAt: ${bloc.state.endAt} endAtText:${endAtText}");
    return Padding(
        padding: const EdgeInsets.all(10),
        child: Form(
          child: Column(
            children: [
              RequisitionEndAtWidget(endAt: bloc.state.endAt,onChange: _selestDateEndAt,),
              const SizedBox(height: 10,),
              if (bloc.state.specifications.isNotEmpty )
                CrmRequisitionPagesEditSelectSpec(
                  specifications: bloc.state.specifications,
                  onSelected: _selectedSpecification,
                ),
              if (bloc.state.tableMateralType != null && bloc.state.specificationMaterials != null  && bloc.state.tableMateralType == 'spec') 
                CrmRequisitionPagesEditSpecificationMaterials(specificationMaterials: bloc.state.specificationMaterials!),

              
            ]
          ,)
        ),
      );
  }
}


class CrmRequisitionPagesEditSpecificationMaterials extends StatelessWidget {
  final List<SpecificationMaterial> specificationMaterials;
  const CrmRequisitionPagesEditSpecificationMaterials({super.key, required this.specificationMaterials});
  @override

  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Table Count Rows ${specificationMaterials.length}"),
        CrmRequisitionPagesEditSpecificationMaterialsTable()
      ],
    );
  }
}

class CrmRequisitionPagesEditSpecificationMaterialsTable extends StatelessWidget {
   CrmRequisitionPagesEditSpecificationMaterialsTable({super.key});
   final List<PlutoColumn> columns = <PlutoColumn>[
      PlutoColumn(
        title: 'Id',
        field: 'id',
        type: PlutoColumnType.text(),
      ),
   ];

  final List<PlutoRow> rows = [
     PlutoRow(cells: {
      'id': PlutoCell(value: 'user1'),
     })
  ];
    @override

  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: PlutoGrid(
          columns: columns,
          rows: rows,
           onLoaded: (PlutoGridOnLoadedEvent event) {
            debugPrint("PlutoGridOnLoadedEvent ${event.toString()}");
          },
          onChanged: (PlutoGridOnChangedEvent event) {
            debugPrint("PlutoGridOnChangedEvent ${event.toString()}");
          },
          configuration: const PlutoGridConfiguration(),
        ),
      ),
    );
  }
}