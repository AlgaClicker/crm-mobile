import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RequisitionEndAtWidget extends StatelessWidget  {
  final DateTime endAt;
  final Function onChange;
  const RequisitionEndAtWidget({super.key,required this.endAt, required this.onChange});
    
  @override

  Widget build(BuildContext context) {
    final String endAtText = DateFormat('dd/MM/yyyy').format(endAt);
    Future<void> selecetDateEnd(BuildContext context) async {
        final DateTime? picked = await showDatePicker(
        helpText: 'До какой даты поставить 1',
        initialDate: DateTime.now().add(const Duration(days: 1)),
        context: context, 
        firstDate: DateTime.now().add(const Duration(days: 1)), 
        lastDate:  DateTime.now().add(const Duration(days: 365)),
        );
        if (picked != null) {
          onChange(picked);
        }
    }

    return TextFormField(
      controller: TextEditingController(text: endAtText),
      onTap: () {
          selecetDateEnd(context);
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
}

