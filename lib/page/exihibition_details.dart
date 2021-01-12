import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:intl/intl.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:saptapadi/controller/exhibition_controller.dart';
import 'package:saptapadi/model/exhibition_model.dart';
import 'package:saptapadi/widget/nav.dart';
import 'package:url_launcher/url_launcher.dart';

class ExihibitionDetails extends StatefulWidget {
  final String hero;
  final String eid;
  final ExhibitionList exhibitionList;

  const ExihibitionDetails({Key key, this.eid, this.hero, this.exhibitionList})
      : super(key: key);

  @override
  _ExihibitionDetailsState createState() => _ExihibitionDetailsState();
}

class _ExihibitionDetailsState extends StateMVC<ExihibitionDetails> {
  ExhibitionController _con;

  _ExihibitionDetailsState() : super(ExhibitionController()) {
    _con = controller;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _con.getExhibitionDetails(widget.eid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    InkWell(
                      child: Icon(
                        Icons.arrow_back_ios,
                        size: 30,
                        color: Colors.black,
                      ),
                      onTap: () {
                        Navigator.of(context).pop(true);
                      },
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          getMonth(widget.exhibitionList.exhibitionDate),
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(getDate(widget.exhibitionList.exhibitionDate),
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      color: Colors.red,
                      width: 1,
                      height: 35,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.exhibitionList.name,
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                          ),
                          Text(
                            widget.exhibitionList.address,
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: _con.exhibitionDetailData != null
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.3,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(
                                          _con.exhibitionDetailData
                                              .exhibitionList.upProImg,
                                        ),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.32,
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: Container(),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 8),
                                        child: Align(
                                            alignment: Alignment.centerRight,
                                            child: Container(
                                                height: 40,
                                                width: 40,
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Colors.red),
                                                child: Center(
                                                  child: Icon(
                                                    Icons.share,
                                                    color: Colors.white,
                                                  ),
                                                ))),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Html(
                              data: _con.exhibitionDetailData.exhibitionList
                                  .description,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: RaisedButton.icon(
                                  color: Colors.redAccent[700],
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: CachedNetworkImage(
                                            imageUrl: _con.exhibitionDetailData
                                                .exhibitionList.entryPassImg,
                                            placeholder: (context, url) => Center(
                                                child:
                                                    CircularProgressIndicator()),
                                            errorWidget:
                                                (context, url, error) =>
                                                    Icon(Icons.error),
                                          ),
                                        );
                                        // Image.network(_con
                                        //     .exhibitionDetailData
                                        //     .exhibitionList
                                        //     .entryPassImg);
                                      },
                                    );
                                  },
                                  icon: Image.asset(
                                    'assets/exhibitions fair/imgFreePass.png',
                                    height: 20,
                                  ),
                                  label: Text(
                                    'Get Free Entry Pass',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'lato'),
                                  )),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    'ADVERTISEMENT',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      _launchURL(_con.exhibitionDetailData
                                          .exhibitionBanner.url);
                                    },
                                    child: CachedNetworkImage(
                                      imageUrl: _con.exhibitionDetailData
                                          .exhibitionBanner.upProImg,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        )
                      : Container(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _launchURL(String openURL) async {
    if (await canLaunch(openURL)) {
      await launch(openURL);
    } else {
      throw 'Could not launch $openURL';
    }
  }

  String getDate(selectedDate) {
    DateTime tempDate = new DateFormat("yyyy-MM-dd").parse(selectedDate, true);
    final detroitTime = tempDate.toLocal();
    print('Detroit Time: ' + detroitTime.toString());
    String date = DateFormat("dd").format(detroitTime);
    return date;
  }

  String getMonth(selectedDate) {
    DateTime tempDate = new DateFormat("yyyy-MM-dd").parse(selectedDate, true);
    final detroitTime = tempDate.toLocal();
    print('Detroit Time: ' + detroitTime.toString());
    String date = DateFormat("MMM").format(detroitTime);
    return date;
  }
}
