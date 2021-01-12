import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:saptapadi/controller/scarchcard_controller.dart';
import 'package:saptapadi/model/scratchcard_user_data.dart';
import 'package:saptapadi/page/scratch.dart';
import 'package:saptapadi/widget/animation.dart';
import 'package:saptapadi/widget/nav.dart';

import 'bottom_navigation_bar.dart';

class ScratchCardUser extends StatefulWidget {
  @override
  _ScratchCardState createState() => _ScratchCardState();
}

class _ScratchCardState extends StateMVC<ScratchCardUser> {
  ScratchCardController _con;

  _ScratchCardState() : super(ScratchCardController()) {
    _con = controller;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _con.getScratchCarduser();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        appBar: Navbar(
          title: 'My Gift',
          elevation: 5,
          backicon: true,
          mycartButton: false,
          buttontitle: 'My Gift',
          mycartTap: () {
            Navigator.push(context, SizeRoute(page: Scratch()));
          },
        ),
        body: _con.scratchCardUserData != null
            ? Container(
                child: ListView.builder(
                  itemCount: _con.scratchCardUserData.scratchCard.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          height: 160,
                          decoration: BoxDecoration(
                            // color: Colors.teal,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: Image.network(
                                    _con.scratchCardUserData.scratchCard[index]
                                        .upProImg,
                                    fit: BoxFit.cover,
                                    width: 120,
                                    height: 135,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      _con.scratchCardUserData
                                          .scratchCard[index].scratchCard,
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    SizedBox(
                                      height: 2,
                                    ),
                                    Text(
                                      _con.scratchCardUserData
                                          .scratchCard[index].vendorName,
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w700),
                                      softWrap: true,
                                    ),
                                    Row(
                                      children: [
                                        Image.asset(
                                          'assets/scratch card/Map.png',
                                          height: 20,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Expanded(
                                          child: Text(
                                            _con
                                                .scratchCardUserData
                                                .scratchCard[index]
                                                .vendorAddress,
                                            softWrap: true,
                                          ),
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Image.asset(
                                          'assets/scratch card/Phone.png',
                                          height: 20,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Expanded(
                                          child: Text(
                                            _con
                                                .scratchCardUserData
                                                .scratchCard[index]
                                                .vendorMobile,
                                            softWrap: true,
                                          ),
                                        )
                                      ],
                                    ),
                                    _con.scratchCardUserData.scratchCard[index]
                                                .redeem ==
                                            "no"
                                        ? RaisedButton(
                                            onPressed: () {
                                              _displayDialog(
                                                  context,
                                                  _con.scratchCardUserData
                                                      .scratchCard[index].id,
                                                  _con
                                                      .scratchCardUserData
                                                      .scratchCard[index]
                                                      .scratchCardId);
                                            },
                                            color: Colors.red[800],
                                            child: Text(
                                              'REDEEM',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15),
                                            ),
                                          )
                                        : Text(
                                            "You Already Redeemed This Scratch Card"),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          color: Colors.grey[300],
                          thickness: 2,
                        ),
                      ],
                    );
                  },
                ),
              )
            : Container(),
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

  _displayDialog(BuildContext context, String gid, String scId) async {
    TextEditingController textFieldController = TextEditingController();
    return showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            elevation: 5,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            child: Container(
              height: 250,
              width: double.infinity,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Enter Security Code(Office Only)'),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: textFieldController,
                        decoration: InputDecoration(
                            hintText: 'Security Code',
                            border: OutlineInputBorder()),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Center(
                        child: RaisedButton(
                            color: Colors.red[800],
                            child: Text(
                              'Submit',
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () {
                              if (textFieldController.text == "") {
                                BotToast.showText(
                                    text: "Please Enter Security Code");
                              } else {
                                _con.scratchcardverify(
                                    gid, scId, textFieldController.text);
                              }
                            }),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
