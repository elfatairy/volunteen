// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:volunteen/presentation/widgets/input.dart';

class VolunteenTimePickerField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;

  const VolunteenTimePickerField({
    super.key,
    required this.controller,
    required this.labelText,
  });

  @override
  _VolunteenTimePickerFieldState createState() =>
      _VolunteenTimePickerFieldState();
}

class _VolunteenTimePickerFieldState extends State<VolunteenTimePickerField> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        TimeOfDay? pickedTime = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
        );
        if (pickedTime != null) {
          setState(() {
            widget.controller.text =
                "${pickedTime.hour.toString().padLeft(2, '0')}:${pickedTime.minute.toString().padLeft(2, '0')}";
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
