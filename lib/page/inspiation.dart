import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:saptapadi/controller/inspiration_controller.dart';
import 'package:saptapadi/page/inspiration_details.dart';
import 'package:saptapadi/widget/nav.dart';

class Inspiration extends StatefulWidget {
  @override
  _InspirationState createState() => _InspirationState();
}

class _InspirationState extends StateMVC<Inspiration> {
  InspirationController con;

  _InspirationState() : super(InspirationController()) {
    con = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: con.scaffoldKey,
        appBar: Navbar(
          title: 'Inspiration',
          backicon: false,
        ),
        body: con.isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: con.inspirationData.statusCode == 0
                    ? Container()
                    : Column(
                        children: [
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: con.inspirationData.inspiration.length,
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
                                        return Inspirationdetails(
                                          heroTag: "inspiration",
                                          inspId: con.inspirationData
                                              .inspiration[index].id,
                                        );
                                      },
                                      transitionsBuilder: (BuildContext context,
                                          Animation<double> animation,
                                          Animation<double> secondaryAnimation,
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
                                child: Stack(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Hero(
                                        tag: "inspiration" +
                                            con.inspirationData
                                                .inspiration[index].id,
                                        child: Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              3,
                                          // width: MediaQuery.of(context).size.width,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                  con
                                                      .inspirationData
                                                      .inspiration[index]
                                                      .upProImg,
                                                ),
                                                fit: BoxFit.cover),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                3,
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Column(
                                            children: [
                                              Expanded(
                                                child: Container(),
                                              ),
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      con
                                                          .inspirationData
                                                          .inspiration[index]
                                                          .groomBrideName,
                                                      style: TextStyle(
                                                          fontSize: 22,
                                                          fontFamily:
                                                              'Pacifico',
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                  Column(
                                                    children: [
                                                      Text(
                                                        "Wedding Date",
                                                        textScaleFactor: 1.1,
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                      Text(
                                                        getDate(con
                                                            .inspirationData
                                                            .inspiration[index]
                                                            .weddingDate),
                                                        textScaleFactor: 1.1,
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
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
                              );
                            },
                          ),
                        ],
                      ),
              ));
  }
}

String getDate(selectedDate) {
  DateTime tempDate = new DateFormat("yyyy-MM-dd").parse(selectedDate, true);
  String date = DateFormat("MMM.dd,yyyy").format(tempDate);
  return date;
}

String getNotifyDate(selectedDate) {
  DateTime tempDate = new DateFormat("yyyy-MM-dd").parse(selectedDate, true);
  String date = DateFormat("dd/MM/yyyy").format(tempDate);
  return date;
}

// SnackBar error = SnackBar(content: Text('Data Not Found'))
