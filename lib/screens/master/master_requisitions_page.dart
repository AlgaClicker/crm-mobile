import 'package:flutter/material.dart';
import 'package:mobile_app/Repositories/master_requisitions_repository.dart';
import 'package:mobile_app/Domain/Crm/requisition.dart';
import 'master_requisition_list_page.dart';

class MasterRequisitionsPage extends StatefulWidget {
  final MasterRequisitionsRepository masterRequisitionsRepository;
  MasterRequisitionsPage({required this.masterRequisitionsRepository});

  @override
  _MasterRequisitionsPageState createState() => _MasterRequisitionsPageState();
}

class _MasterRequisitionsPageState extends State<MasterRequisitionsPage> {
  late List<Requisition> _requisitions;
  int _currentPage = 1;
  bool _isLoading = false;
  bool _hasMore = true;

  @override
  void initState() {
    super.initState();
    _requisitions = [];
    _loadRequisitions();
  }

  Future<void> _loadRequisitions() async {
    if (_isLoading || !_hasMore) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final newRequisitions =
          await widget.masterRequisitionsRepository.fetchRequisitions(
        page: _currentPage,
      );

      setState(() {
        _requisitions.addAll(newRequisitions);
        _isLoading = false;
        _hasMore = newRequisitions.length > 0;
        if (_hasMore) _currentPage++;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading requisitions: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Список заявок'),
        actions: [
          IconButton(
            onPressed: ()=>{
              Navigator.pushNamed(context, '/master/requisition/new')
            }, 
            icon: Icon(Icons.add)
          )
        ],
      ),
      body: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent &&
              !_isLoading) {
            _loadRequisitions();
          }
          return false;
        },
        child: RequisitionListPage(
          requisitions: _requisitions,
        ),
      ),
      bottomNavigationBar: _isLoading
          ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircularProgressIndicator(),
            )
          : null,
    );
  }
}
