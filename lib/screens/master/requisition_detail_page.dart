import 'package:flutter/material.dart';
import 'package:mobile_app/Domain/Crm/requisition.dart';

class RequisitionDetailPage extends StatelessWidget {
  final Requisition requisition;

  RequisitionDetailPage({required this.requisition});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Заявка: ${requisition.number}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Номер: ${requisition.number}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            Text(
              'Status: ${requisition.status}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 8.0),
            Text(
              'Type: ${requisition.type}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 8.0),
            Text(
              'Created At: ${requisition.createdAt.toLocal()}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 8.0),
            Text(
              'Author: ${requisition.author.username}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 16.0),
            if (requisition.materials != null &&
                requisition.materials!.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Materials:',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8.0),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: requisition.materials!.length,
                    itemBuilder: (context, index) {
                      final material = requisition.materials![index];
                      return Card(
                        margin: EdgeInsets.symmetric(vertical: 4.0),
                        child: ListTile(
                          title: Text(material.materialName ??
                              material.material?.name ??
                              'Unknown Material'),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (material.material != null)
                                Text(
                                  'Material: ${material.material!.name ?? 'N/A'}',
                                  style: TextStyle(color: Colors.grey[700]),
                                ),
                              if (material.unit != null)
                                Text(
                                  'Unit: ${material.unit!.name ?? ''}',
                                  style: TextStyle(color: Colors.grey[700]),
                                ),
                              Text(
                                'Quantity: ${material.quantity ?? 'N/A'}',
                                style: TextStyle(color: Colors.grey[700]),
                              ),
                              if (material.description != null &&
                                  material.description!.isNotEmpty)
                                Text(
                                  'Description: ${material.description}',
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
}
