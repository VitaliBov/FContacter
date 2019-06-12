import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:photo_view/photo_view.dart';

class ImageScreen extends StatelessWidget {
  ImageScreen(
      this.url,
      {Key key}
  ) : super(key: key);

  final String url;

  Widget build(BuildContext context) => Scaffold(
      body: PhotoView(
          imageProvider: CachedNetworkImageProvider(url)
      )
  );
}