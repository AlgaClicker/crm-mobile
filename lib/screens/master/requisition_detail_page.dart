import 'package:flutter/material.dart';
import 'package:mobile_app/Domain/Crm/requisition.dart';
import 'package:intl/intl.dart';



class RequisitionDetailPage extends StatelessWidget {
  final Requisition requisition;

  
  RequisitionDetailPage({required this.requisition});

  String getLocalizedStatus(String statusProps) {
    switch (statusProps) {
      case 'new':
        return 'Не рассмотрена';
      case 'manage':
        return 'Взята в работу';
      case 'inprogress':
        return 'В процессе';
      case 'agreement':
        return 'Согласование';
      case 'completed':
        return 'Завершена';
      case 'canceled':
        return 'Отменена';
      default:
        return 'Черновик';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Заявка: ${requisition.number}'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Номер: ${requisition.number}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16.0),
            Text(
              'Статус: ${getLocalizedStatus(requisition.status)}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 8.0),
            Text(
              'Тип: ${requisition.type}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 8.0),
            Text(
              'Создано: ${_formatDate(requisition.createdAt)}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 8.0),
            if (requisition.endAt != null)
              Text(
                'Поставить до: ${ requisition.endAt.toString() }',
                style: TextStyle(fontSize: 18),
              ),
            const SizedBox(height: 8.0),
            Text(
              'Автор: ${_buildAuthorInfo(requisition)}',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 16.0),
            if (requisition.materials != null &&
                requisition.materials!.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Материалы:',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8.0),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: requisition.materials!.length,
                    itemBuilder: (context, index) {
                      final material = requisition.materials![index];
                      return Card(
                        margin: EdgeInsets.symmetric(vertical: 4.0),
                        child: ListTile(
                          title: Text(
                            'Material: ${material.material?.name ?? material.materialName ?? 'Unknown Material'}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 4.0),
                              Text(
                                'Quantity: ${material.quantity ?? 'N/A'} ${material.unit?.name ?? ''}',
                                style: TextStyle(color: Colors.grey[700]),
                              ),
                              const SizedBox(height: 4.0),
                              if (material.description != null &&
                                  material.description!.isNotEmpty)
                                Text(
                                  'Description: ${material.description}',
                                  style: TextStyle(color: Colors.grey[700]),
                                ),
                              const SizedBox(height: 4.0),
                              if (material.material != null)
                                Text(
                                  'Material Details: ${material.material?.description ?? 'No description available'}',
                                  style: TextStyle(color: Colors.grey[700]),
                                ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            if (requisition.materials == null || requisition.materials!.isEmpty)
              Text(
                'No materials in this requisition.',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
          ],
        ),
      ),
    );
  }

  String _buildAuthorInfo(Requisition requisition) {
    if (requisition.author.workpeople != null) {
      final fullName = '${requisition.author.workpeople!.surname} ${requisition.author.workpeople!.name} ${requisition.author.workpeople!.patronymic ?? ''}';
      final role = requisition.author.role.name;
      return '$fullName (${role})';
    } else {
      return requisition.author.username;
    }
  }


  String _formatDate(DateTime date) {
    final DateFormat formatter = DateFormat('d MMMM y', 'ru');
    return formatter.format(date).replaceAll(' г.', 'г.');
  }

}
