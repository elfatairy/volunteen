// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageLoaderWidget extends StatefulWidget {
  final String id;
  final Function function;
  double? height;
  double? width;

  ImageLoaderWidget({
    required this.id,
    required this.function,
    this.height,
    this.width,
    super.key,
  });

  @override
  _ImageWidgetState createState() => _ImageWidgetState();
}

class _ImageWidgetState extends State<ImageLoaderWidget> {
  Future<String>? _imageFuture;

  @override
  void initState() {
    super.initState();
    _imageFuture = _getHelpingHandImage();
  }

  Future<String> _getHelpingHandImage() {
    return widget.function();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: widget.width,
      height: widget.height,
      child: FutureBuilder<String>(
        future: _imageFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 20,
                ),
                child: CircularProgressIndicator(),
              ),
            );
          } else if (snapshot.hasError) {
            return Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 20,
              ),
              child: const Icon(Icons.error),
            );
          } else {
            final String imageLink = snapshot.data ?? '';
            return SizedBox(
              child: CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl: imageLink,
                placeholder: (context, url) => Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 20,
                  ),
                  child: const CircularProgressIndicator(),
                ),
                errorWidget: (context, url, error) => Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 20,
                  ),
                  child: const Icon(Icons.error),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
