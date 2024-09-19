import 'package:flutter/material.dart';
import 'package:mobile_app/Domain/Crm/requisition.dart';
import 'requisition_detail_page.dart'; // Импорт страницы деталей

class RequisitionListPage extends StatefulWidget {
  final List<Requisition> requisitions;

  RequisitionListPage({required this.requisitions});

  @override
  _RequisitionListPageState createState() => _RequisitionListPageState();
}

class _RequisitionListPageState extends State<RequisitionListPage> {
  late List<Requisition> _filteredRequisitions;
  String _sortBy = 'number';
  String _filter = '';

  @override
  void initState() {
    super.initState();
    _filteredRequisitions = widget.requisitions;
  }

  void _sortRequisitions() {
    setState(() {
      if (_sortBy == 'number') {
        _filteredRequisitions.sort((a, b) => a.number.compareTo(b.number));
      } else if (_sortBy == 'status') {
        _filteredRequisitions.sort((a, b) => a.status.compareTo(b.status));
      } else if (_sortBy == 'date') {
        _filteredRequisitions
            .sort((a, b) => a.createdAt.compareTo(b.createdAt));
      }
    });
  }

  void _filterRequisitions() {
    setState(() {
      _filteredRequisitions = widget.requisitions.where((req) {
        return req.number.contains(_filter) ||
            req.status.contains(_filter) ||
            req.author.username.contains(_filter);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Filter',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    _filter = value;
                    _filterRequisitions();
                  },
                ),
              ),
              SizedBox(width: 16.0),
              DropdownButton<String>(
                value: _sortBy,
                items: [
                  DropdownMenuItem(
                      value: 'number', child: Text('Sort by Number')),
                  DropdownMenuItem(
                      value: 'status', child: Text('Sort by Status')),
                  DropdownMenuItem(value: 'date', child: Text('Sort by Date')),
                ],
                onChanged: (value) {
                  if (value != null) {
                    _sortBy = value;
                    _sortRequisitions();
                  }
                },
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _filteredRequisitions.length,
            itemBuilder: (context, index) {
              final requisition = _filteredRequisitions[index];
              return Card(
                margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: ListTile(
                  title: Text(
                    requisition.number,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 4.0),
                      Text(
                        'Status: ${requisition.status}',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                      SizedBox(height: 4.0),
                      Text(
                        'Type: ${requisition.type}',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                      SizedBox(height: 4.0),
                      Text(
                        'Created At: ${requisition.createdAt.toLocal()}',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                      SizedBox(height: 4.0),
                      Text(
                        'Author: ${requisition.author.username}',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                    ],
                  ),
                  trailing: Icon(Icons.arrow_forward_ios, size: 16.0),
                  onTap: () {
                    // Переход на страницу деталей заявки
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            RequisitionDetailPage(requisition: requisition),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
