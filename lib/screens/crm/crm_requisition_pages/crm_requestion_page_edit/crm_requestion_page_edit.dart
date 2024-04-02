import 'package:flutter/material.dart';
import 'package:date_picker_plus/date_picker_plus.dart';

class CrmRequisitionPagesEdit extends StatelessWidget {
  const CrmRequisitionPagesEdit({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Новая заявка"),
      ),
      body: Column(
        children: [
          RangeDatePicker(
            centerLeadingDate: true,
            minDate: DateTime.now(),
            maxDate: DateTime(2033,12,31),
            onRangeSelected: (value) {
              
            },
          )
        ],
      ),
    );
  }
}