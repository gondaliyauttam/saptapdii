import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_countdown_timer/index.dart';
import 'package:intl/intl.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:path_provider/path_provider.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:saptapadi/controller/home_page_controller.dart';
import 'package:saptapadi/page/wedding_profile.dart';
import 'package:saptapadi/repository/user_repository.dart';
import 'dart:io';
import 'package:saptapadi/utils/constants.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart' as shareimage;

class Home extends StatefulWidget {
  const Home({
    Key key,
  }) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends StateMVC<Home> {
  CountdownTimerController controller1;
  HomeController _con;
  GlobalKey previewContainer = new GlobalKey();
  int originalSize = 800;
  _HomeState() : super(HomeController()) {
    _con = controller;
  }

  bool cameraimg = false;
  String lastSelectedValue;

  @override
  void initState() {
    super.initState();
    _con.getCheckLitdatatodo();
    int endTime = DateTime.now().millisecondsSinceEpoch +
        1000 * 60 * 60 * getDifference();
    controller1 = CountdownTimerController(endTime: endTime, onEnd: onEnd);
  }

  void onEnd() {
    print('onEnd');
  }

  // File image;
  final picker = ImagePicker();

  Future getImage(ImageSource source) async {
    final pickedFile = await picker.getImage(source: source);

    setState(() {
      if (pickedFile != null) {
        image = File(pickedFile.path);
        cameraimg = true;
      }
      _con.updateProfilePic(File(pickedFile.path));
      // Navigator.of(context).pop();
    });
  }

  void showDemoActionSheet({BuildContext context, Widget child}) {
    showCupertinoModalPopup<String>(
      context: context,
      builder: (BuildContext context) => child,
    ).then((String value) {
      if (value != null) {
        setState(() {
          lastSelectedValue = value;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  RepaintBoundary(
                    key: previewContainer,
                    child: Container(
                        height: 280,
                        width: MediaQuery.of(context).size.width,
                        child: Stack(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width,
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 20),
                                child: image != null
                                    ? Image.file(
                                        image,
                                        fit: BoxFit.cover,
                                        height:
                                            MediaQuery.of(context).size.height,
                                      )
                                    : /*Image.network(
                                        currentUser.weddingProfile.upProImg,
                                        fit: BoxFit.cover,
                                      )*/
                                    CachedNetworkImage(
                                        width: 100,
                                        imageUrl: currentUser
                                                    .weddingProfile.upProImg !=
                                                null
                                            ? currentUser
                                                .weddingProfile.upProImg
                                            : "",
                                        fit: BoxFit.cover,
                                        height:
                                            MediaQuery.of(context).size.height,
                                        placeholder: (context, url) => Center(
                                            child: SizedBox(
                                                height: 50,
                                                width: 50,
                                                child:
                                                    const CircularProgressIndicator())),
                                        errorWidget: (context, url, error) =>
                                            Image.asset(
                                          'assets/home/imgDashboard.jpg',
                                          height: MediaQuery.of(context)
                                              .size
                                              .height,
                                          fit: BoxFit.cover,
                                        ),
                                        fadeOutDuration:
                                            const Duration(seconds: 1),
                                        fadeInDuration:
                                            const Duration(seconds: 3),
                                      ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          currentUser.weddingProfile.groomName,
                                          textScaleFactor: 2.1,
                                          style: TextStyle(
                                              fontFamily: 'Pacifico',
                                              color: Colors.white),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          "&",
                                          textScaleFactor: 2,
                                          style: TextStyle(
                                              fontFamily: 'Pacifico',
                                              color: Colors.white),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          currentUser.weddingProfile.brideName,
                                          textScaleFactor: 2.1,
                                          style: TextStyle(
                                              fontFamily: 'Pacifico',
                                              color: Colors.white),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            Navigator.of(context).push(
                                              PageRouteBuilder(
                                                transitionDuration:
                                                    Duration(milliseconds: 500),
                                                pageBuilder: (BuildContext
                                                        context,
                                                    Animation<double> animation,
                                                    Animation<double>
                                                        secondaryAnimation) {
                                                  return WeddingProfile();
                                                },
                                                transitionsBuilder:
                                                    (BuildContext context,
                                                        Animation<double>
                                                            animation,
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
                                          child: Container(
                                            height: 25,
                                            width: 25,
                                            child: Image.asset(
                                              'assets/home/imgEditPen.png',
                                              height: 20,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    Text(
                                      currentUser.weddingProfile.weddingDate !=
                                              ""
                                          ? getDate(currentUser
                                              .weddingProfile.weddingDate)
                                          : "",
                                      textScaleFactor: 1.1,
                                      style: TextStyle(color: Colors.white),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                margin: EdgeInsets.only(
                                  top: 180,
                                ),
                                child: currentUser.weddingProfile.weddingDate !=
                                        ""
                                    ? CountdownTimer(
                                        controller: controller1,
                                        widgetBuilder: (BuildContext context,
                                            CurrentRemainingTime time) {
                                          if (time == null) {
                                            return Center(
                                              child: Text(
                                                'congratulations !',
                                                textScaleFactor: 2,
                                                style: TextStyle(
                                                    fontFamily: 'Pacifico',
                                                    color: Colors.white),
                                              ),
                                            );
                                          }
                                          List<Widget> list = [];
                                          if (time.days != null) {
                                            list.add(Expanded(
                                              child: Column(
                                                children: <Widget>[
                                                  Text(
                                                    time.days.toString(),
                                                    textScaleFactor: 2,
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                  Text('Days',
                                                      style: TextStyle(
                                                          color: Colors.white)),
                                                ],
                                              ),
                                            ));
                                          }
                                          if (time.hours != null) {
                                            list.add(Expanded(
                                              child: Column(
                                                children: <Widget>[
                                                  Text(
                                                    time.hours.toString(),
                                                    textScaleFactor: 2,
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                  Text('Hours',
                                                      style: TextStyle(
                                                          color: Colors.white)),
                                                ],
                                              ),
                                            ));
                                          }
                                          if (time.min != null) {
                                            list.add(Expanded(
                                              child: Column(
                                                children: <Widget>[
                                                  Text(
                                                    time.min.toString(),
                                                    textScaleFactor: 2,
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                  Text('Mins',
                                                      style: TextStyle(
                                                          color: Colors.white)),
                                                ],
                                              ),
                                            ));
                                          }
                                          if (time.sec != null) {
                                            list.add(Expanded(
                                              child: Column(
                                                children: <Widget>[
                                                  Text(
                                                    time.sec.toString(),
                                                    textScaleFactor: 2,
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                  Text('Sec',
                                                      style: TextStyle(
                                                          color: Colors.white)),
                                                ],
                                              ),
                                            ));
                                          }

                                          return Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: list,
                                            ),
                                          );
                                        },
                                      )
                                    : SizedBox(),
                              ),
                            )
                          ],
                        )),
                  ),
                  Positioned(
                    right: -5.0,
                    top: 10.0,
                    child: Stack(
                      children: <Widget>[
                        RawMaterialButton(
                          onPressed: () {
                            _con.openNotification();
                          },

                          fillColor: Colors.white,
                          child: Image.asset(
                            'assets/home/imgNotification.png',
                            height: 15,
                            width: 30,
                          ),
                          // padding: EdgeInsets.all(10.0),
                          shape: CircleBorder(),
                        ),
                        new Positioned(
                          right: 50.0,
                          top: -2.0,
                          child: new Stack(
                            children: <Widget>[
                              new Icon(Icons.brightness_1,
                                  size: 20.0, color: Colors.red[900]),
                              new Positioned(
                                top: 1.0,
                                right: 5.0,
                                child: new Text(
                                    currentUser.notificationCount.count,
                                    style: new TextStyle(
                                        color: Colors.white,
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.w500)),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  // Positioned(
                  //   right: -5.0,
                  //   top: 10.0,
                  //   child: Container(
                  //       child: RawMaterialButton(
                  //     onPressed: () {
                  //       Navigator.of(context).pushNamed('/Notifications');
                  //     },

                  //     fillColor: Colors.white,
                  //     child: Image.asset(
                  //       'assets/home/imgNotification.png',
                  //       height: 15,
                  //       width: 30,
                  //     ),
                  //     // padding: EdgeInsets.all(10.0),
                  //     shape: CircleBorder(),
                  //   )),
                  // ),
                  Positioned(
                    left: -10.0,
                    top: 10.0,
                    child: Container(
                      child: RawMaterialButton(
                        onPressed: () {
                          showDemoActionSheet(
                              context: context,
                              child: CupertinoActionSheet(
                                actions: <Widget>[
                                  CupertinoActionSheetAction(
                                    child: Text('Gallery'),
                                    onPressed: () async {
                                      await getImage(ImageSource.gallery);
                                    },
                                  ),
                                  CupertinoActionSheetAction(
                                    child: Text('Camera'),
                                    onPressed: () async {
                                      //setState(() {
                                      await getImage(ImageSource.camera);
                                      // });
                                    },
                                  ),
                                ],
                                cancelButton: CupertinoActionSheetAction(
                                  child: Text('Cancel'),
                                  isDefaultAction: true,
                                  onPressed: () {
                                    Navigator.pop(context, 'Cancle');
                                  },
                                ),
                              ));
                        },
                        fillColor: Colors.white,
                        child: Image.asset(
                          'assets/home/imgCamera.png',
                          height: 20,
                          width: 30,
                        ),
                        // padding: EdgeInsets.all(10.0),
                        shape: CircleBorder(),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: -5,
                    right: -5.0,
                    child: Container(
                      child: RawMaterialButton(
                        onPressed: () {
                          takeScreenShot();
                        },
                        fillColor: Colors.white,
                        child: Image.asset(
                          'assets/home/imgShare.png',
                          height: 20,
                          width: 30,
                        ),
                        // padding: EdgeInsets.all(10.0),
                        shape: CircleBorder(),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: GestureDetector(
                  onTap: _con.openCheckListPage,
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Image.asset(
                                'assets/home/imgChecklist@2x.png',
                                height: 35,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'My CheckList',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'lato'),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      text: currentUser
                                          .myChecklist.doneChecklist
                                          .toString(),
                                      style: TextStyle(
                                          fontSize: 17,
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold),
                                      children: <TextSpan>[
                                        TextSpan(
                                            text:
                                                '/ ${currentUser.myChecklist.totalChecklist}',
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black)),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    'tasks done',
                                    style: TextStyle(
                                        fontSize: 15, fontFamily: 'lato'),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 16),
                            child: CircularPercentIndicator(
                              radius: 60.0,
                              animation: true,
                              animationDuration: 1200,
                              lineWidth: 3.0,
                              percent: currentUser.myChecklist.doneChecklist /
                                  currentUser.myChecklist.totalChecklist,
                              center: new Text(
                                "${(currentUser.myChecklist.doneChecklist / currentUser.myChecklist.totalChecklist * 100).round()}%",
                                style: new TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12.0),
                              ),
                              circularStrokeCap: CircularStrokeCap.butt,
                              backgroundColor: Colors.grey,
                              progressColor: Colors.red,
                            ),
                          )
                        ],
                      ),
                    ),
                    elevation: 5,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: InkWell(
                  /* onTap: () {

                    Navigator.push(
                        context, SizeRoute(page: VenderShhortListMainPage()));
                  },*/
                  onTap: _con.openVendorShortListPage,
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Image.asset(
                            'assets/home/imgVendorShortlist@2x.png',
                            height: 35,
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Vendor Shortlists',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'lato'),
                              ),
                              Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        currentUser.myShortlist.totalShortlist
                                            .toString(),
                                        style: TextStyle(
                                            fontSize: 17,
                                            color: Colors.red,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        'shortlists',
                                        style: TextStyle(
                                          fontFamily: 'lato',
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          currentUser.myShortlist.totalFinalised
                                              .toString(),
                                          style: TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          'Finished',
                                          style: TextStyle(
                                            fontFamily: 'lato',
                                            fontSize: 15,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    elevation: 5,
                  ),
                ),
              ),
              Row(
                children: <Widget>[
                  Container(
                    height: 125,
                    width: MediaQuery.of(context).size.width / 2,
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed('/Discountoffer');
                        },
                        child: Card(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Image.asset('assets/home/imgOffer@3x.png',
                                  height: 50),
                              Text(
                                'Discounts\n & Offers',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    fontFamily: 'lato'),
                              )
                            ],
                          ),
                          elevation: 5,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 125,
                    width: MediaQuery.of(context).size.width / 2,
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed('/Scratch');
                        },
                        child: Card(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Image.asset('assets/home/imgScratchCard@2x.png',
                                  height: 50),
                              Text(
                                'Scratch\n Card',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    fontFamily: 'lato'),
                              )
                            ],
                          ),
                          elevation: 5,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  int getDifference() {
    final cTime = DateTime.now();

    DateTime startTime = new DateFormat("yyyy-MM-dd")
        .parse(currentUser.weddingProfile.weddingDate);
    final differenceMinuts = startTime.difference(cTime).inHours;

    return differenceMinuts;
  }

  takeScreenShot() async {
    RenderRepaintBoundary boundary =
        previewContainer.currentContext.findRenderObject();
    double pixelRatio = originalSize / MediaQuery.of(context).size.width;
    ui.Image image = await boundary.toImage(pixelRatio: pixelRatio);
    ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List pngBytes = byteData.buffer.asUint8List();
    if (pngBytes != null) {
      shareimage.Share.file(
        'esys image',
        'esys.png',
        pngBytes.buffer.asUint8List(),
        'image/png',
      );
    }
    final directory = (await getApplicationDocumentsDirectory()).path;
    File imgFile = new File('$directory/screenshot.png');
    imgFile.writeAsBytes(pngBytes);
  }
}
