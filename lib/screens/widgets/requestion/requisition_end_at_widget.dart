import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RequisitionEndAtWidget extends StatefulWidget {
  final DateTime endAt;
  final Function onChange;
  const RequisitionEndAtWidget({super.key,required this.endAt, required this.onChange});

  @override
  Future<DateTime?> _selecetDateEnd(BuildContext context) async {
      final DateTime? _picked = await showDatePicker(
      helpText: 'До какой даты поставить',
      initialDate: DateTime.now().add(const Duration(days: 1)),
      context: context, 
      firstDate: DateTime.now().add(const Duration(days: 1)), 
      lastDate:  DateTime.now().add(const Duration(days: 365)),
      
    );
    onChange(_picked);
    return _picked;
  }

  Future<void> selectDate() async {

  }

  _RequisitionEndAtWidget createState() => _RequisitionEndAtWidget(endAt: endAt,onChange: onChange);
}

class _RequisitionEndAtWidget extends State<RequisitionEndAtWidget> {
  final DateTime endAt;
  final Function onChange;
  _RequisitionEndAtWidget({required this.endAt, required this.onChange});



  
  @override
  Widget build(BuildContext context) {
    final String endAtText = DateFormat('dd/MM/yyyy').format(endAt);
    return TextFormField(
      controller: TextEditingController(text: endAtText),
      onTap: () {
        setState(() {
          final endAt = _selecetDateEnd(context);
          
          onChange(endAt);

        });
      },
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

  @override
  Future<DateTime?> _selecetDateEnd(BuildContext context) async {
      final DateTime? _picked = await showDatePicker(
      helpText: 'До какой даты поставить',
      initialDate: DateTime.now().add(const Duration(days: 1)),
      context: context, 
      firstDate: DateTime.now().add(const Duration(days: 1)), 
      lastDate:  DateTime.now().add(const Duration(days: 365)),
    );
    return _picked;
  }



}  