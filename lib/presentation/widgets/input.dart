import 'package:flutter/material.dart';

// ignore: must_be_immutable
class VolunteenTextFormField extends StatelessWidget {
  final String labelText;
  bool? isObscure;
  ValueChanged<String>? onChange;
  TextEditingController? controller;
  String? Function(String?)? validator;
  TextInputType? textInputType;
  int? maxLines;
  String? initialValue;
  TextAlign? textAlign;
  TextDirection? textDirection;
  InputDecoration? inputDecoration;
  double? fontSize;
  VolunteenTextFormField({
    super.key,
    required this.labelText,
    this.onChange,
    this.controller,
    this.validator,
    this.textInputType,
    this.maxLines,
    this.isObscure,
    this.initialValue,
    this.textAlign,
    this.textDirection,
    this.inputDecoration,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: Text(
              labelText,
              textAlign: textAlign ?? TextAlign.start,
              style: TextStyle(
                fontSize: fontSize ?? 14,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: controller,
            onChanged: onChange,
            cursorColor: Colors.black,
            initialValue: initialValue,
            textDirection: textDirection,
            decoration: inputDecoration ??
                InputDecoration(
                  border: borderStyle(),
                  enabledBorder: borderStyle(),
                  focusedBorder: borderStyle(),
                  labelStyle: const TextStyle(
                    color: Colors.black,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 10.0),
                ),
            obscureText: isObscure ?? false,
            validator: validator,
            keyboardType: textInputType,
            maxLines: maxLines ?? 1,
          ),
        ],
      ),
    );
  }

  OutlineInputBorder borderStyle() {
    return OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.grey[400]!,
        width: 2,
      ),
      borderRadius: BorderRadius.circular(12),
    );
  }
}
