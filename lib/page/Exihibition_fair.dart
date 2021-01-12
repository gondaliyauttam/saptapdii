import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:saptapadi/controller/exhibition_controller.dart';
import 'package:saptapadi/page/exihibition_details.dart';
import 'package:saptapadi/widget/nav.dart';

class ExihibitionFair extends StatefulWidget {
  @override
  _ExihibitionFairState createState() => _ExihibitionFairState();
}

class _ExihibitionFairState extends StateMVC<ExihibitionFair> {
  ExhibitionController _con;

  _ExihibitionFairState() : super(ExhibitionController()) {
    _con = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _con.scaffoldKey,
        appBar: Navbar(
          title: 'Exihibition & Fair',
        ),
        body: _con.isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: _con.exhibitionData == null
                    ? Container()
                    : Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            ListView.builder(
                              shrinkWrap: true,
                              itemCount:
                                  _con.exhibitionData.exhibitionList.length,
                              itemBuilder: (BuildContext context, int index) {
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
                                          return ExihibitionDetails(
                                            hero: "Exhibition",
                                            eid: _con.exhibitionData
                                                .exhibitionList[index].id,
                                            exhibitionList: _con.exhibitionData
                                                .exhibitionList[index],
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
                                  child: Column(
                                    children: [
                                      Hero(
                                        child: Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              3,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(3),
                                            image: DecorationImage(
                                                image:
                                                    CachedNetworkImageProvider(
                                                  _con
                                                      .exhibitionData
                                                      .exhibitionList[index]
                                                      .upProImg,
                                                ),
                                                fit: BoxFit.cover),
                                          ),
                                        ),
                                        tag: "Exhibition" +
                                            _con.exhibitionData
                                                .exhibitionList[index].id,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                getMonth(_con
                                                    .exhibitionData
                                                    .exhibitionList[index]
                                                    .exhibitionDate),
                                                style: TextStyle(
                                                    color: Colors.red,
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                  getDate(_con
                                                      .exhibitionData
                                                      .exhibitionList[index]
                                                      .exhibitionDate),
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold)),
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
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  _con
                                                      .exhibitionData
                                                      .exhibitionList[index]
                                                      .name,
                                                  style: TextStyle(
                                                      fontSize: 22,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily: 'lato'),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  softWrap: true,
                                                ),
                                                Text(
                                                  _con
                                                      .exhibitionData
                                                      .exhibitionList[index]
                                                      .address,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  softWrap: true,
                                                  style: TextStyle(
                                                      fontFamily: 'lato'),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      )
                                    ],
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
              ));
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
