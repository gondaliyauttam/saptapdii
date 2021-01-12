import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:saptapadi/controller/discoount_controller.dart';
import 'package:saptapadi/page/bottom_navigation_bar.dart';
import 'package:saptapadi/widget/animation.dart';
import 'package:saptapadi/widget/dialogbox.dart';
import 'package:saptapadi/widget/nav.dart';

class Discountoffer extends StatefulWidget {
  @override
  _DiscountofferState createState() => _DiscountofferState();
}

class _DiscountofferState extends StateMVC<Discountoffer> {
  Discountcontroller _con;

  _DiscountofferState() : super(Discountcontroller()) {
    _con = controller;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: SafeArea(
        child: Scaffold(
          appBar: Navbar(
            title: 'Discount & Offer',
          ),
          key: _con.scaffoldKey,
          body: _con.isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Stack(
                  children: [
                    _con.discountData == null
                        ? Container()
                        : SingleChildScrollView(
                            child: Column(
                              children: [
                                Stack(
                                  children: [
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              1.8,
                                      child: Image.network(
                                        _con.discountData.sponserList[0]
                                            .upProImg,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Container(
                                      margin:
                                          EdgeInsets.only(top: 250, left: 10),
                                      height: 150,
                                      width: 250,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            _con.discountData.sponserList[0]
                                                    .vendorName +
                                                "(" +
                                                _con.discountData.sponserList[0]
                                                    .vendorCategory +
                                                ")",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15),
                                          ),
                                          Text(
                                            _con.discountData.sponserList[0]
                                                .discount,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return Dialogbox(
                                                    title: _con
                                                        .discountData
                                                        .sponserList[0]
                                                        .vendorAddress,
                                                    description: _con
                                                        .discountData
                                                        .sponserList[0]
                                                        .description,
                                                  );
                                                },
                                              );
                                            },
                                            child: Text(
                                              "Check Now",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18),
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Container(
                                    // color: Colors.red,
                                    height: 250.0,
                                    // width: 200,
                                    child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        shrinkWrap: true,
                                        itemCount: _con
                                            .discountData.discountList.length,
                                        itemBuilder:
                                            (BuildContext context, int i) {
                                          return Container(
                                              height: 260.0,
                                              width: 170.0,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    child: Image.network(
                                                      _con
                                                          .discountData
                                                          .discountList[i]
                                                          .upProImg,
                                                      fit: BoxFit.cover,
                                                      width: 150,
                                                      height: 150,
                                                    ),
                                                  ),
                                                  Text(
                                                    _con
                                                        .discountData
                                                        .discountList[i]
                                                        .vendorCategory,
                                                    style: TextStyle(
                                                        color: Colors.grey),
                                                  ),
                                                  Text(
                                                    _con
                                                        .discountData
                                                        .discountList[i]
                                                        .vendorName,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w900,
                                                        fontSize: 14),
                                                  ),
                                                  Text(
                                                    _con
                                                        .discountData
                                                        .discountList[i]
                                                        .vendorAddress,
                                                  ),
                                                ],
                                              ));
                                        })),
                              ],
                            ),
                          ),
                  ],
                ),
        ),
      ),
    );
  }

  Future<bool> _onBackPressed() {
    return Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => Bottomnavigationbar(
                currenttab: 2,
              )),
    );
  }
}
