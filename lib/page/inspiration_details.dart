import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:saptapadi/controller/inspiration_controller.dart';
import 'package:saptapadi/model/inspiration_detail_data.dart';
import 'package:saptapadi/page/inspiation.dart';
import 'package:saptapadi/page/wedding_venue_details.dart';
import 'package:saptapadi/widget/animation.dart';
import 'package:saptapadi/widget/image_detail_widget.dart';
import 'package:saptapadi/widget/nav.dart';
import 'package:html/parser.dart';

class Inspirationdetails extends StatefulWidget {
  final String heroTag;
  final String inspId;

  const Inspirationdetails({Key key, this.heroTag, this.inspId});

  @override
  _InspirationdetailsState createState() => _InspirationdetailsState();
}

class _InspirationdetailsState extends StateMVC<Inspirationdetails> {
  InspirationController _con;

  _InspirationdetailsState() : super(InspirationController()) {
    _con = controller;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _con.getInspirationDetailData(widget.inspId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Navbar(
        title: 'Inspiration',
      ),
      body: _con.isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: _con.inspirationDetailData != null
                  ? Column(
                      children: [
                        InkWell(
                          onTap: () {},
                          child: Stack(
                            children: [
                              Hero(
                                tag: widget.heroTag + widget.inspId,
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height / 3,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(
                                          _con.inspirationDetailData.upProImg,
                                        ),
                                        fit: BoxFit.cover),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                      children: [
                                        Expanded(
                                          child: Container(),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                _con.inspirationDetailData
                                                    .groomBrideName,
                                                textScaleFactor: 2,
                                                style: TextStyle(
                                                    fontFamily: 'Pacifico',
                                                    color: Colors.white),
                                              ),
                                            ),
                                            Column(
                                              children: [
                                                Text(
                                                  "Wedding Date",
                                                  textScaleFactor: 1.1,
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                                Text(
                                                  getDate(_con
                                                      .inspirationDetailData
                                                      .weddingDate),
                                                  textScaleFactor: 1.1,
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                parseHtmlString(
                                  _con.inspirationDetailData.description,
                                ),
                                textAlign: TextAlign.justify,
                                style: TextStyle(fontFamily: 'lato'),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Gallery',
                                style: TextStyle(fontWeight: FontWeight.w900),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                  // color: Colors.red,
                                  height: 120.0,
                                  // width: 200,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: _con.inspirationDetailData
                                        .vendergallery.length,
                                    itemBuilder:
                                        (BuildContext context, int i) =>
                                            InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            SizeRoute(
                                                page: Imagedetail(
                                                    vendergallery: _con
                                                        .inspirationDetailData
                                                        .vendergallery)));
                                      },
                                      child: Card(
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          child: Image.network(
                                            _con.inspirationDetailData
                                                .vendergallery[i].upProImg,
                                            fit: BoxFit.cover,
                                            width: 100,
                                            height: 100,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                'Credit to Vendors',
                                style: TextStyle(fontWeight: FontWeight.w900),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  itemCount: _con.inspirationDetailData
                                      .vendorCredit.length,
                                  itemBuilder: (BuildContext context, int i) {
                                    return InkWell(
                                      onTap: () {
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
                                                    .inspirationDetailData
                                                    .vendorCredit[i]
                                                    .vid,
                                                vendordetailNAME: _con
                                                    .inspirationDetailData
                                                    .vendorCredit[i]
                                                    .name,
                                                heroTag: "inspiration_vendor",
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
                                      },
                                      child: Inspirationwidget(
                                          vendorCredit: _con
                                              .inspirationDetailData
                                              .vendorCredit[i]),
                                    );
                                  })
                            ],
                          ),
                        ),
                      ],
                    )
                  : Container(),
            ),
    );
  }

  String parseHtmlString(String htmlString) {
    var document = parse(htmlString);

    String parsedString = parse(document.body.text).documentElement.text;

    return parsedString;
  }
}

class Inspirationwidget extends StatelessWidget {
  final VendorCredit vendorCredit;

  const Inspirationwidget({Key key, this.vendorCredit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          child: Hero(
            tag: "inspiration_vendor" + vendorCredit.vid,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image.network(
                vendorCredit.upProImg,
                fit: BoxFit.cover,
                width: 120,
                height: 120,
              ),
            ),
          ),
        ),
        SizedBox(
          width: 5,
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                vendorCredit.category,
                style: TextStyle(color: Colors.grey),
              ),
              Text(
                vendorCredit.name,
                textScaleFactor: 1.2,
                style:
                    TextStyle(fontWeight: FontWeight.w900, fontFamily: 'lato'),
                softWrap: true,
              ),
              Text(
                vendorCredit.address,
                style: TextStyle(fontFamily: 'lato'),
              ),
            ],
          ),
        )
      ],
    );
  }
}
