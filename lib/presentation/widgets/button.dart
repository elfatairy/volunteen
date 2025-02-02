// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:volunteen/presentation/themes/colors.dart';

class VolunteenFilledElevatedButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  double? fontSize;
  double? height;
  double? borderWidth;
  Color? borderColor;
  Color? backgroundColor;
  String? imagePath;
  Color? textColor;
  double? borderRadius;
  FontWeight? fontWeight;
  VolunteenFilledElevatedButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.fontSize,
    this.height,
    this.borderWidth,
    this.borderColor,
    this.backgroundColor,
    this.imagePath,
    this.textColor,
    this.borderRadius,
    this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 40,
      child: ElevatedButton(
        onPressed: () => onPressed(),
        style: ButtonStyle(
          shape: borderRadius != null
              ? WidgetStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(borderRadius!),
                  ),
                )
              : null,
          side: WidgetStateProperty.all(
            BorderSide(
              width: borderWidth ?? 2,
              color: borderColor ?? Colors.black,
            ),
          ),
          backgroundColor: WidgetStateProperty.all<Color>(
            backgroundColor ?? VolunteenColors.vanilla,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: fontSize ?? 15,
                  color: textColor ?? Colors.black,
                  fontWeight: fontWeight,
                ),
              ),
              if (imagePath != null) ...[
                const SizedBox(width: 8),
                Image.asset(imagePath!),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
