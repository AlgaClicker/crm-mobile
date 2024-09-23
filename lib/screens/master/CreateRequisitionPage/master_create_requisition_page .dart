import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'create_page_requisition_bloc.dart';
import 'create_page_requisition_event.dart';
import 'create_page_requisition_state.dart';
import 'package:mobile_app/Domain/Crm/requisition_materials.dart';
import 'package:mobile_app/Domain/Systems/unit.dart';

class CreateRequisitionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Создать заявку')),
      body: BlocListener<MasterPageRequisitionBloc, RequisitionState>(
        listener: (context, state) {
          if (state.isSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Заявка успешно создана')),
            );
            Navigator.of(context).pop(); // Возвращаемся назад после успешного создания
          }
          if (state.isFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Ошибка при создании заявки')),
            );
          }
        },
        child: SingleChildScrollView( // Обертка для предотвращения переполнения
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _EndAtInput(),
                _SpecificationInput(),
                _CommentInput(),
                _MaterialsInput(),
                _AddMaterialButton(),
                const SizedBox(height: 20), // Пространство перед кнопкой
                _SubmitButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _EndAtInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MasterPageRequisitionBloc, RequisitionState>(
      builder: (context, state) {
        return TextField(
          controller: TextEditingController(text: state.endAt.toString().split(' ')[0]),
          decoration: const InputDecoration(labelText: 'Дата завершения'),
          onTap: () async {
            FocusScope.of(context).requestFocus(FocusNode());
            DateTime? picked = await showDatePicker(
              context: context,
              initialDate: state.endAt,
              firstDate: DateTime.now(),
              lastDate: DateTime(2101),
            );
            if (picked != null) {
              context.read<MasterPageRequisitionBloc>().add(RequisitionEndAtChanged(picked));
            }
          },
        );
      },
    );
  }
}

class _SpecificationInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MasterPageRequisitionBloc, RequisitionState>(
      builder: (context, state) {
        return TextField(
          decoration: const InputDecoration(labelText: 'Спецификация (необязательно)'),
          onChanged: (value) => context.read<MasterPageRequisitionBloc>().add(RequisitionSpecificationChanged(value)),
        );
      },
    );
  }
}

class _CommentInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MasterPageRequisitionBloc, RequisitionState>(
      builder: (context, state) {
        return TextField(
          decoration: const InputDecoration(labelText: 'Комментарий'),
          maxLines: 3,
          onChanged: (value) => context.read<MasterPageRequisitionBloc>().add(RequisitionCommentChanged(value)),
        );
      },
    );
  }
}

class _MaterialsInput extends StatelessWidget {
  final TextEditingController _materialNameController = TextEditingController();
  final TextEditingController _materialQuantityController = TextEditingController();
  final TextEditingController _materialUnitController = TextEditingController();
  final TextEditingController _materialCommentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: _materialNameController,
          decoration: const InputDecoration(labelText: 'Наименование материала'),
        ),
        TextField(
          controller: _materialQuantityController,
          decoration: const InputDecoration(labelText: 'Количество'),
          keyboardType: TextInputType.number,
        ),
        TextField(
          controller: _materialUnitController,
          decoration: const InputDecoration(labelText: 'Единица измерения'),
        ),
        TextField(
          controller: _materialCommentController,
          decoration: const InputDecoration(labelText: 'Комментарий к материалу'),
        ),
      ],
    );
  }
}

class _AddMaterialButton extends StatelessWidget {
  final TextEditingController _materialNameController = TextEditingController();
  final TextEditingController _materialQuantityController = TextEditingController();
  final TextEditingController _materialUnitController = TextEditingController();
  final TextEditingController _materialCommentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        final material = RequisitionMaterials(
          id: '', // ID назначается на сервере
          materialName: _materialNameController.text,
          quantity: double.tryParse(_materialQuantityController.text) ?? 0,
          unit: Unit(code: _materialUnitController.text, name: ""), // Дополнить правильным значением
          description: _materialCommentController.text,
        );

        context.read<MasterPageRequisitionBloc>().add(RequisitionMaterialAdded(material));

        _materialNameController.clear();
        _materialQuantityController.clear();
        _materialUnitController.clear();
        _materialCommentController.clear();
      },
      child: const Text('Добавить материал'),
    );
  }
}

class _SubmitButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MasterPageRequisitionBloc, RequisitionState>(
      builder: (context, state) {
        return state.isSubmitting
            ? const CircularProgressIndicator()
            : ElevatedButton(
                onPressed: () {
                  context.read<MasterPageRequisitionBloc>().add(RequisitionSubmitted());
                },
                child: const Text('Создать заявку'),
              );
      },
    );
  }
}
