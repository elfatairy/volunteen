import 'package:flutter/material.dart';
import 'package:volunteen/presentation/widgets/image_loader.dart';

class DonationAbstract extends StatelessWidget {
  final String id;
  final String title;
  final String description;
  final String location;
  final Function function;
  final bool? isFav;
  final bool? isForDelete;
  final Function deleteMethod;
  final Function? addMethod;

  const DonationAbstract({
    super.key,
    required this.id,
    required this.title,
    required this.description,
    required this.location,
    required this.function,
    this.isFav,
    this.isForDelete,
    required this.deleteMethod,
    this.addMethod,
  });

  @override
  Widget build(BuildContext context) {
    bool isRTL = Directionality.of(context) == TextDirection.rtl;

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 5.0,
      margin: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ImageLoaderWidget(
              id: id,
              function: function,
              width: 80,
              height: 80,
            ),
            const SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    textAlign: isRTL ? TextAlign.right : TextAlign.left,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.grey[800],
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: isRTL ? TextAlign.right : TextAlign.left,
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    location,
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.grey[800],
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: isRTL ? TextAlign.right : TextAlign.left,
                  ),
                ],
              ),
            ),
            if (isFav != null)
              Center(
                child: IconButton(
                  onPressed: isFav! ? () => deleteMethod() : () => addMethod!(),
                  icon: isFav!
                      ? const Icon(
                          Icons.favorite,
                          color: Colors.red,
                        )
                      : const Icon(
                          Icons.favorite_outline,
                          color: Colors.red,
                        ),
                ),
              ),
            if (isForDelete != null)
              Center(
                child: IconButton(
                  onPressed: () => deleteMethod(),
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
