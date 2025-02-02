// ignore_for_file: library_private_types_in_public_api, use_super_parameters

import 'package:flutter/material.dart';
import 'package:volunteen/presentation/widgets/input.dart';

class VolunteenDatePickerField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;

  const VolunteenDatePickerField({
    Key? key,
    required this.controller,
    required this.labelText,
  }) : super(key: key);

  @override
  _VolunteenDatePickerFieldState createState() =>
      _VolunteenDatePickerFieldState();
}

class _VolunteenDatePickerFieldState extends State<VolunteenDatePickerField> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
        );
        if (pickedDate != null) {
          setState(() {
            widget.controller.text =
                "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
          });
        }
      },
      child: AbsorbPointer(
        child: VolunteenTextFormField(
          labelText: widget.labelText,
          controller: widget.controller,
          textInputType: TextInputType.datetime,
        ),
      ),
    );
  }
}
