import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ShowImage extends StatelessWidget {
  final String url;
  ShowImage({this.url});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: PhotoView(imageProvider: CachedNetworkImageProvider(url)),
    );
  }
}
