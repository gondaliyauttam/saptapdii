import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:saptapadi/controller/vender_controller.dart';
import 'package:saptapadi/model/vender_catagory.dart';
import 'package:saptapadi/widget/animation.dart';
import 'package:saptapadi/widget/galerry_image_widget.dart';
import 'package:saptapadi/widget/nav.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:html/parser.dart';

class WeddingDetails extends StatefulWidget {
  final String vendordetailID;
  final String vendordetailNAME;
  final String heroTag;

  const WeddingDetails(
      {Key key,
      @required this.vendordetailID,
      @required this.vendordetailNAME,
      this.heroTag})
      : super(key: key);

  @override
  _WeddingDetailsState createState() => _WeddingDetailsState();
}

_launchURL(String openURL) async {
  if (await canLaunch(openURL)) {
    await launch(openURL);
  } else {
    throw 'Could not launch $openURL';
  }
}

class _WeddingDetailsState extends StateMVC<WeddingDetails> {
  VendorsController _con;

  _WeddingDetailsState() : super(VendorsController()) {
    _con = controller;
  }

  @override
  void initState() {
    super.initState();
    _con.getVendorDetailother(widget.vendordetailID);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Navbar(
        title: widget.vendordetailNAME,
      ),
      body: _con.venderdetail == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Weddingdetails(
                id: widget.vendordetailID,
                heroTag: widget.heroTag,
                title: _con.venderdetail.name,
                subtitle: _con.venderdetail.address,
                image: _con.venderdetail.upProImg,
                description: _con.venderdetail.description,
                mobile: _con.venderdetail.contactNo,
                whatsapp: _con.venderdetail.whatsappMobile,
                facebook: _con.venderdetail.facebook,
                instagram: _con.venderdetail.instagram,
                pintrest: _con.venderdetail.pintrest,
                twitter: _con.venderdetail.twitter,
                youtube: _con.venderdetail.youtube,
                number: _con.venderdetail.vendorsGallery.length.toString(),
                vendergallery: _con.venderdetail.vendorsGallery,
                vendorShortlist: _con.venderdetail.vendorShortlist,
                ontap: () {
                  if (_con.venderdetail.vendorShortlist == "yes") {
                    _con.removevendershortlist(widget.vendordetailID);
                  } else {
                    _con.addvendershortlist(widget.vendordetailID);
                  }
                },
              ),
            ),
    );
  }
}

class Weddingdetails extends StatelessWidget {
  final String id;
  final String heroTag;
  final String title;
  final String subtitle;
  final String description;
  final String image;
  final String number;
  final String whatsapp;
  final String facebook;
  final String instagram;
  final String pintrest;
  final String twitter;
  final String youtube;
  final String mobile;
  final String vendorShortlist;
  final Function ontap;
  final List<VendorGallery> vendergallery;

  const Weddingdetails({
    Key key,
    this.id,
    this.heroTag,
    this.title,
    this.subtitle,
    this.description,
    this.image,
    this.number,
    this.ontap,
    this.mobile,
    this.whatsapp,
    this.facebook,
    this.instagram,
    this.pintrest,
    this.twitter,
    this.youtube,
    this.vendorShortlist,
    this.vendergallery,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Hero(
                tag: heroTag + id,
                child: CachedNetworkImage(
                  imageUrl: image,
                  placeholder: (context, url) =>
                      Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
            vendorShortlist == "yes"
                ? Positioned(
                    right: -5.0,
                    top: 10.0,
                    child: RawMaterialButton(
                      onPressed: ontap,
                      fillColor: Colors.red[800],
                      child: Image.asset(
                        'assets/vendor_list/imgBookmark.png',
                        height: 15,
                        width: 30,
                      ),
                      shape: CircleBorder(),
                    ),
                  )
                : Positioned(
                    right: -5.0,
                    top: 10.0,
                    child: RawMaterialButton(
                      onPressed: ontap,
                      fillColor: Colors.black54,
                      child: Image.asset(
                        'assets/vendor_list/imgBookmark.png',
                        height: 15,
                        width: 30,
                      ),
                      shape: CircleBorder(),
                    ),
                  ),
            Positioned(
              left: 10.0,
              top: 20.0,
              child: InkWell(
                onTap: () {
                  Navigator.pushReplacement(
                      context, SizeRoute(page: Galleryimage(vendergallery)));
                },
                child: Container(
                  height: 25,
                  width: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    color: Colors.black54,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/vendor_list/imgCamera.png',
                        height: 17,
                        width: 30,
                      ),
                      Text(
                        number,
                        textScaleFactor: 1.1,
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 150, left: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    textScaleFactor: 1.5,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  Text(
                    subtitle,
                    maxLines: 2,
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            )
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              children: [
                FlatButton.icon(
                  onPressed: () {
                    _launchURL('tel:${mobile}');
                  },
                  label: Text(
                    'Call',
                    textScaleFactor: 1.2,
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  icon: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(width: 1, color: Colors.black26)),
                    child: Image.asset(
                      'assets/vendor_details/call.png',
                      height: 20,
                    ),
                  ),
                ),
                FlatButton.icon(
                  onPressed: () {
                    _launchURL('whatsapp://send?phone=+91 ${whatsapp}');
                  },
                  label: Text(
                    'Chat',
                    textScaleFactor: 1.1,
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  icon: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(width: 1, color: Colors.black26)),
                    child: Image.asset(
                      'assets/vendor_details/whatsapp.png',
                      height: 20,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'About',
                textScaleFactor: 1.2,
                style:
                    TextStyle(fontWeight: FontWeight.bold, fontFamily: 'lato'),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                parseHtmlString(description),
                textAlign: TextAlign.justify,
                style: TextStyle(fontFamily: 'lato'),
              ),
              /* Html(
                data: description,
                shrinkWrap: true,
                style: {
                  "body": Style(
                    textAlign: TextAlign.justify,
                  ),
                },
              ),*/
              SizedBox(
                height: 10,
              ),
              Text(
                'Social Media',
                textScaleFactor: 1.2,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  facebook != ""
                      ? Socialitem(
                          image: 'assets/vendor_details/facebook.png',
                          ontap: () {
                            _launchURL('https://${facebook}');
                          },
                        )
                      : SizedBox(
                          height: 0,
                        ),
                  SizedBox(
                    width: 5,
                  ),
                  instagram != ""
                      ? Socialitem(
                          image: 'assets/vendor_details/instgram.png',
                          ontap: () {
                            _launchURL('https://${instagram}');
                          },
                        )
                      : SizedBox(
                          height: 0,
                        ),
                  SizedBox(
                    width: 5,
                  ),
                  youtube != ""
                      ? Socialitem(
                          image: 'assets/vendor_details/youtube.png',
                          ontap: () {
                            _launchURL('https://${youtube}');
                          },
                        )
                      : SizedBox(
                          height: 0,
                        ),
                  SizedBox(
                    width: 5,
                  ),
                  twitter != ""
                      ? Socialitem(
                          image: 'assets/vendor_details/twitter.png',
                          ontap: () {
                            _launchURL('https://${twitter}');
                          },
                        )
                      : SizedBox(
                          height: 0,
                        ),
                  SizedBox(
                    width: 5,
                  ),
                  pintrest != ""
                      ? Socialitem(
                          image: 'assets/vendor_details/pinterest.png',
                          ontap: () {
                            _launchURL('https://${pintrest}');
                          },
                        )
                      : SizedBox(
                          height: 0,
                        ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }

  String parseHtmlString(String htmlString) {
    var document = parse(htmlString);

    String parsedString = parse(document.body.text).documentElement.text;

    return parsedString;
  }
}

class Socialitem extends StatelessWidget {
  final String image;
  final Function ontap;

  const Socialitem({
    Key key,
    this.image,
    this.ontap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Image.asset(
        image,
        height: 45,
        width: 45,
      ),
    );
  }
}
