import 'package:flutter/material.dart';
import 'package:volunteen/presentation/themes/colors.dart';

class HelpRequestInfoRow extends StatelessWidget {
  final String label;
  final String value;

  const HelpRequestInfoRow({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "$label:",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: VolunteenColors.pink,
            ),
          ),
          const SizedBox(width: 8.0),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                color: VolunteenColors.darkBlue,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
