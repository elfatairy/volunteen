import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class VolunteenHomeScreenSliderItem extends StatelessWidget {
  final String title;
  final String subtitle;
  const VolunteenHomeScreenSliderItem({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      color: Colors.black,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(5),
            decoration: const BoxDecoration(
              color: Color(0xffDCE7F5),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: AutoSizeText(
              title,
              maxLines: 2,
              minFontSize: 10,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 20,
                color: Color(
                  0xff002060,
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  children: [
                    AutoSizeText(
                      subtitle,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(color: Colors.yellow),
                  child: const Text("Hey"),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
