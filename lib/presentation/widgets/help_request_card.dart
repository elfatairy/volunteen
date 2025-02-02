import 'package:flutter/material.dart';
import 'package:volunteen/data/models/help_request.dart';
import 'package:volunteen/presentation/themes/colors.dart';
import 'package:volunteen/utility/string_utility.dart';

class VolunteenHelpRequestCard extends StatelessWidget {
  final HelpRequest helpRequest;
  final VoidCallback onTap;
  final VoidCallback onDelete;
  final bool isEditAuth;

  const VolunteenHelpRequestCard({
    super.key,
    required this.helpRequest,
    required this.onTap,
    required this.onDelete,
    required this.isEditAuth,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: VolunteenColors.lightGrey,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    helpRequest.title,
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: VolunteenColors.darkBlue,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    StringUtility.getHelpCategoryName(
                      helpRequest.category,
                      context,
                    ),
                    style: const TextStyle(
                      fontSize: 14.0,
                      color: VolunteenColors.orange,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    helpRequest.location,
                    style: const TextStyle(
                      fontSize: 14.0,
                      color: VolunteenColors.blue,
                    ),
                  ),
                ],
              ),
              const Expanded(child: SizedBox()),
              if (isEditAuth)
                IconButton(
                  onPressed: onDelete,
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                    size: 30,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
