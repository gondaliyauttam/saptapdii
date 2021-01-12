import 'package:flutter/material.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:saptapadi/model/vender_catagory.dart';
import 'package:photo_view/photo_view.dart';

class Imagedetail extends StatefulWidget {
  final List<VendorGallery> vendergallery;

  const Imagedetail({Key key, @required this.vendergallery}) : super(key: key);
  @override
  _ImagedetailState createState() => _ImagedetailState();
}

class _ImagedetailState extends State<Imagedetail> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: PhotoViewGallery.builder(
      scrollPhysics: const BouncingScrollPhysics(),
      builder: (BuildContext context, int index) {
        return PhotoViewGalleryPageOptions(
          tightMode: true,
          imageProvider: NetworkImage(widget.vendergallery[index].upProImg),
          initialScale: PhotoViewComputedScale.contained * 0.9,
          heroAttributes: PhotoViewHeroAttributes(
              tag: widget.vendergallery[index].upProImg),
        );
      },
      itemCount: widget.vendergallery.length,
      loadingBuilder: (context, event) => Center(
        child: Container(
          width: 20.0,
          height: 20.0,
          child: CircularProgressIndicator(
            value: event == null
                ? 0
                : event.cumulativeBytesLoaded / event.expectedTotalBytes,
          ),
        ),
      ),
    ));
  }
}
