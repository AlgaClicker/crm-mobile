import 'package:flutter/material.dart';
import 'package:mobile_alga_crm/domain/entity/crm/specification.dart';

class CrmRequisitionPagesEditSelectSpec extends StatelessWidget {
  const CrmRequisitionPagesEditSelectSpec({super.key, required this.specifications, required this.onSelected});
  final Function onSelected;
  final List<Specification> specifications;
  @override

  Widget build(BuildContext context) {
    final Specification specificationEmpty = Specification(id: '00000000-0000-0000-0000-000000000000', name: 'НЕТ');
    if (!specifications.contains(specificationEmpty)) {
      specifications.add(specificationEmpty);
    }
    return DropdownButtonFormField<String>(
      value: null,
      isExpanded: true,
      icon: const Icon(Icons.arrow_downward),
      
      style: const TextStyle(color: Colors.deepPurple),
      onChanged:(value) {
        onSelected(value);
          debugPrint("!CrmRequisitionPagesEditSelectSpec: onChanged val: ${value.toString()} ");
      },
      decoration: const InputDecoration(
        labelText: 'Спцификация',
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
      items: specifications.reversed.map<DropdownMenuItem<String>>((Specification specification) {
        return DropdownMenuItem<String>(
          value: specification.id,
          child: Row(
            children: [
              Text(specification.name),
              const SizedBox(width: 5),
              if (specification.objectName != null) 
                Text(
                  specification.objectName.toString(),
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold
                  ),
                ),
            ],
          ),
        );
      }).toList(),
    );


  }
}
