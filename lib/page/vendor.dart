import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:saptapadi/controller/vender_controller.dart';
import 'package:saptapadi/page/wedding_venue_details.dart';
import 'package:saptapadi/widget/animation.dart';
import 'package:saptapadi/widget/galerry_image_widget.dart';
import 'package:saptapadi/widget/nav.dart';
import 'package:url_launcher/url_launcher.dart';

class Vendors extends StatefulWidget {
  final String vendorID;
  final String vendorNAME;

  const Vendors({Key key, @required this.vendorID, @required this.vendorNAME})
      : super(key: key);

  @override
  _VendorsState createState() => _VendorsState();
}

class _VendorsState extends StateMVC<Vendors> {
  VendorsController _con;

  _VendorsState() : super(VendorsController()) {
    _con = controller;
  }

  @override
  void initState() {
    super.initState();
    _con.getVendorDetail(widget.vendorID);
    // _con.getVendorDetail(widget.vendorNAME);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Navbar(
        title: widget.vendorNAME,
      ),
      body: _con.vendor == null
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Container(
                child: Column(
                  children: [
                    _con.vendorsBanner != null
                        ? InkWell(
                            onTap: () {
                              _launchURL(_con.vendorsBanner[0].url);
                            },
                            child: CachedNetworkImage(
                              imageUrl: _con.vendorsBanner[0].upProImg,
                              placeholder: (context, url) =>
                                  Center(child: CircularProgressIndicator()),
                            ))
                        : Container(),
                    SizedBox(
                      height: 10,
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: _con.vendor.vendorsList.length,
                      itemBuilder: (BuildContext context, int index) {
                        // return Text(_con.vendor.vendorsList[index].name);
                        return Container(
                          child: Column(
                            children: <Widget>[
                              Stack(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 20),
                                    child: Hero(
                                      tag: "vendor_details" +
                                          _con.vendor.vendorsList[index].id,
                                      child: CachedNetworkImage(
                                        imageUrl: _con
                                            .vendor.vendorsList[index].upProImg,
                                        placeholder: (context, url) => Center(
                                            child: CircularProgressIndicator()),
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.error),
                                      ),
                                    ),
                                  ),
                                  _con.vendor.vendorsList[index]
                                              .vendorShortlist ==
                                          "yes"
                                      ? Positioned(
                                          right: -5.0,
                                          top: 10.0,
                                          child: RawMaterialButton(
                                            onPressed: () {
                                              _con.removevendershortlist(_con
                                                  .vendor
                                                  .vendorsList[index]
                                                  .id);
                                            },
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
                                            onPressed: () {
                                              _con.addvendershortlist(_con
                                                  .vendor
                                                  .vendorsList[index]
                                                  .id);
                                            },
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
                                        Navigator.push(
                                            context,
                                            SizeRoute(
                                                page: Galleryimage(_con
                                                    .vendor
                                                    .vendorsList[index]
                                                    .vendorGallery)));
                                      },
                                      child: Container(
                                        height: 25,
                                        width: 60,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(3),
                                          color: Colors.black54,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              'assets/vendor_list/imgCamera.png',
                                              height: 17,
                                              width: 30,
                                            ),
                                            Text(
                                              _con.vendor.vendorsList[index]
                                                  .vendorGallery.length
                                                  .toString(),
                                              textScaleFactor: 1.1,
                                              style: TextStyle(
                                                  color: Colors.white),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 170, left: 20),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          _con.vendor.vendorsList[index].name,
                                          overflow: TextOverflow.ellipsis,
                                          textScaleFactor: 1.5,
                                          maxLines: 2,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          _con.vendor.vendorsList[index]
                                              .address,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              Container(
                                height: 60,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      right: 17, left: 17),
                                  child: Html(
                                    data: _con
                                        .vendor.vendorsList[index].description,
                                    style: {
                                      "body": Style(
                                          textAlign: TextAlign.justify,
                                          fontFamily: 'lato'),
                                    },
                                  ),
                                  // Text(
                                  //   description,
                                  //   textAlign: TextAlign.justify,
                                  //   maxLines: 4,
                                  // ),
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.9,
                                child: RaisedButton(
                                    child: Text(
                                      'READ MORE',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    color: Colors.red[800],
                                    onPressed: () {
                                      // Navigator.of(context)
                                      //     .pushNamed('/WeddingDetails', arguments: vendorID);
                                      Navigator.of(context).push(
                                        PageRouteBuilder(
                                          transitionDuration:
                                              Duration(milliseconds: 500),
                                          pageBuilder: (BuildContext context,
                                              Animation<double> animation,
                                              Animation<double>
                                                  secondaryAnimation) {
                                            return WeddingDetails(
                                              vendordetailID: _con
                                                  .vendor.vendorsList[index].id,
                                              vendordetailNAME: _con.vendor
                                                  .vendorsList[index].name,
                                              heroTag: "vendor_details",
                                            );
                                          },
                                          transitionsBuilder:
                                              (BuildContext context,
                                                  Animation<double> animation,
                                                  Animation<double>
                                                      secondaryAnimation,
                                                  Widget child) {
                                            return Align(
                                              child: FadeTransition(
                                                opacity: animation,
                                                child: child,
                                              ),
                                            );
                                          },
                                        ),
                                      );
                                      /*Navigator.push(
                      context,
                      SizeRoute(
                          page: WeddingDetails(
                        vendordetailID: vendorID,
                        vendordetailNAME: vendorName,
                        vendergallery: vendergallery,
                      )));*/
                                    }),
                              ),
                              SizedBox(
                                height: 15,
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

_launchURL(String openURL) async {
  if (await canLaunch(openURL)) {
    await launch(openURL);
  } else {
    throw 'Could not launch $openURL';
  }
}
