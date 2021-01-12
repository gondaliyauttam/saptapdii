import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:saptapadi/model/vender_catagory.dart';
import 'package:saptapadi/widget/image_detail_widget.dart';
import 'package:saptapadi/widget/nav.dart';
import 'animation.dart';

class Galleryimage extends StatefulWidget {
  List<VendorGallery> vendergallery;
  Galleryimage(this.vendergallery, {Key key}) : super(key: key);

  @override
  _GalleryimageState createState() => _GalleryimageState();
}

class _GalleryimageState extends StateMVC<Galleryimage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Navbar(
        title: 'Image',
      ),
      body: widget.vendergallery != null
          ? GridView.builder(
              // padding: const EdgeInsets.all(4.0),
              scrollDirection: Axis.vertical,
              itemCount: widget.vendergallery.length,
              gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, childAspectRatio: 1.2),
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          SizeRoute(
                              page: Imagedetail(
                            vendergallery: widget.vendergallery,
                          )));
                    },
                    child: Container(
                      child: ClipRRect(
                          child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl: widget.vendergallery[index].upProImg,
                        placeholder: (context, url) => Center(
                          child: CircularProgressIndicator(),
                        ),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      )),
                    ),
                  ),
                );
              },
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
