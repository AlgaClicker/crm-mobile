import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/Domain/Crm/specification.dart';
import 'Specification/master_specifications_page_bloc.dart';
import 'Specification/master_specifications_page_bloc_event.dart';
import 'Specification/master_specifications_page_bloc_state.dart';

class MasterSpecificationsPage extends StatefulWidget {
  @override
  _MasterSpecificationsPageState createState() => _MasterSpecificationsPageState();
}

class _MasterSpecificationsPageState extends State<MasterSpecificationsPage> {
  @override
  void initState() {
    super.initState();
    _loadSpecifications();
  }

  void _loadSpecifications() {
    context.read<MasterSpecificationsPageBloc>().add(MasterSpecificationsFetched());
  }

  Future<void> _onRefresh() async {
    context.read<MasterSpecificationsPageBloc>().add(MasterSpecificationsFetched());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Спецификации'),
        actions: [
          IconButton(onPressed: _onRefresh, icon: Icon(Icons.refresh))
        ],
      ),
      body: BlocBuilder<MasterSpecificationsPageBloc, MasterSpecificationsPageBlocState>(
        builder: (context, state) {
          if (state.status == SpecificationsPageStatus.failure) {
            return const Center(child: Text('Ошибка при загрузке спецификаций'));
          }
          if (state.status == SpecificationsPageStatus.success) {
            if (state.specifications.isEmpty) {
              return const Center(child: Text('Спецификаций нет'));
            }
            return RefreshIndicator(
              onRefresh: _onRefresh,
              child: ListView.builder(
                itemCount: state.specifications.length,
                itemBuilder: (BuildContext context, int index) {
                  final Specification specification = state.specifications[index];
                  return ListTile(
                    title: Text(specification.name),
                    subtitle: Text('Дата: ${specification.id}'),
                    onTap: () {
                      context.read<MasterSpecificationsPageBloc>().add(MasterSpecificationSelected(specification.id));
                      Navigator.pop(context, specification);  // Вернуть выбранную спецификацию на предыдущую страницу
                    },
                  );
                },
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
