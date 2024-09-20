import 'package:flutter/material.dart';
import 'package:mobile_app/Domain/Crm/requisition.dart';
import 'requisition_detail_page.dart'; // Импорт страницы деталей
import 'package:intl/intl.dart';

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

  Future<void> _refreshRequisitions() async {
    // Здесь вы можете обновить данные списка, например, повторно получить данные с сервера
    // Для демонстрации, просто ждем 1 секунду
    await Future.delayed(Duration(seconds: 1));
    // После обновления данных обновляем состояние виджета
    setState(() {
      _filteredRequisitions = widget.requisitions;
    });
  }

  void _sortRequisitions() {
    setState(() {
      if (_sortBy == 'number') {
        _filteredRequisitions.sort((a, b) => a.number.compareTo(b.number));
      } else if (_sortBy == 'status') {
        _filteredRequisitions.sort((a, b) => a.status.compareTo(b.status));
      } else if (_sortBy == 'date') {
        _filteredRequisitions.sort((a, b) => a.createdAt.compareTo(b.createdAt));
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
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: const InputDecoration(
                    labelText: 'Фильтр',
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
                items: const [
                  DropdownMenuItem(value: 'number', child: Text('Sort by Number')),
                  DropdownMenuItem(value: 'status', child: Text('Sort by Status')),
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
          child: RefreshIndicator(
            onRefresh: _refreshRequisitions,
            child: ListView.builder(
              itemCount: _filteredRequisitions.length,
              itemBuilder: (context, index) {
                final requisition = _filteredRequisitions[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  child: ListTile(
                    title: Text(
                      'Заявка: ${requisition.number}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4.0),
                        Text(
                          'Статус: ${getLocalizedStatus(requisition.status)}',
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                        const SizedBox(height: 4.0),
                        Text(
                          'Тип: ${requisition.type}',
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                        const SizedBox(height: 4.0),
                        Text(
                          'Создано: ${_formatDate(requisition.createdAt)}',
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                        Text(
                          'Автор: ${_buildAuthorInfo(requisition)}',
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                      ],
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16.0),
                    onTap: () {
                      // Переход на страницу деталей заявки
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RequisitionDetailPage(requisition: requisition),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ),
      ],
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
