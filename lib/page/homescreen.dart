import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_color/flutter_color.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:saptapadi/controller/homescreenbanner_controller.dart';
import 'package:saptapadi/page/bottom_navigation_bar.dart';
import 'package:saptapadi/page/discount_offer.dart';
import 'package:saptapadi/page/favourite.dart';
import 'package:saptapadi/page/scratch.dart';
import 'package:saptapadi/page/scratch_%20card.dart';
import 'package:saptapadi/page/service.dart';
import 'package:saptapadi/widget/animation.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

Future<void> _launchURL(String openURL) async {
  if (await canLaunch(openURL)) {
    await launch(openURL);
  } else {
    throw 'Could not launch $openURL';
  }
}

class _HomeScreenState extends StateMVC<HomeScreen> {
  HomescreenbannerController _con;
  _HomeScreenState() : super(HomescreenbannerController()) {
    _con = controller;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Stack(children: [
              Container(
                height: MediaQuery.of(context).size.height / 1.3,
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    _con.menuScreenBanner != null
                        ? InkWell(
                            onTap: () {
                              _launchURL(_con.menuScreenBanner.url);
                            },
                            child: CachedNetworkImage(
                              fit: BoxFit.fill,
                              imageUrl: _con.menuScreenBanner.upProImg,
                              height: MediaQuery.of(context).size.height / 1.3,
                              placeholder: (context, url) => Container(),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            ),
                          )
                        : Center(child: CircularProgressIndicator()),
                    Container(
                      child: Column(
                        children: [
                          Expanded(
                            child: Container(),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              HomeItem(
                                ontap: () {
                                  Navigator.pushReplacement(
                                      context,
                                      SizeRoute(
                                          page: Bottomnavigationbar(
                                        currenttab: 2,
                                      )));
                                  // Navigator.of(context)
                                  //     .pushNamed('/Bottomnavigationbar', arguments: 2);
                                },
                                image: 'assets/Homescreenicons/home_icon.png',
                              ),
                              HomeItem(
                                ontap: () {
                                  Navigator.pushReplacement(
                                      context,
                                      SizeRoute(
                                          page: Bottomnavigationbar(
                                        currenttab: 0,
                                      )));
                                  // Navigator.of(context)
                                  //     .pushNamed('/Bottomnavigationbar', arguments: 0);
                                },
                                image: 'assets/Homescreenicons/vendor_icon.png',
                              ),
                              HomeItem(
                                ontap: () {
                                  Navigator.pushReplacement(
                                      context,
                                      SizeRoute(
                                          page: Bottomnavigationbar(
                                        currenttab: 1,
                                      )));
                                  // Navigator.of(context)
                                  //     .pushNamed('/Bottomnavigationbar', arguments: 1);
                                },
                                image:
                                    'assets/Homescreenicons/trending_today.png',
                              ),
                              HomeItem(
                                ontap: () {
                                  Navigator.pushReplacement(
                                      context,
                                      SizeRoute(
                                          page: Bottomnavigationbar(
                                        currenttab: 3,
                                      )));
                                  // Navigator.of(context)
                                  //     .pushNamed('/Bottomnavigationbar', arguments: 3);
                                },
                                image:
                                    'assets/Homescreenicons/inspiration_icon.png',
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ]),
            Expanded(
              child: _con.menuScreenBanner != null
                  ? Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      color: HexColor(
                        _con.menuScreenBanner.colorCode.replaceAll('0x', '#'),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          HomeItem(
                            ontap: () {
                              Navigator.pushReplacement(
                                  context, SizeRoute(page: Discountoffer()));
                              // Navigator.of(context).pushNamed('/Discountoffer');
                            },
                            image: 'assets/Homescreenicons/discount_icon.png',
                          ),
                          HomeItem(
                            ontap: () {
                              Navigator.pushReplacement(
                                  context, SizeRoute(page: ScratchCardUser()));
                              // Navigator.of(context).pushNamed('/ScratchCard');
                            },
                            image: 'assets/Homescreenicons/scratch_icon.png',
                          ),
                          HomeItem(
                            image: 'assets/Homescreenicons/faviourite_icon.png',
                            ontap: () {
                              Navigator.pushReplacement(
                                  context, SizeRoute(page: Favourite()));
                              // Navigator.of(context).pushNamed('/Service');
                            },
                          ),
                          HomeItem(
                            ontap: () {
                              Navigator.pushReplacement(
                                  context, SizeRoute(page: Service()));
                              // Navigator.of(context)
                              //     .pushReplacementNamed('/Service');
                            },
                            image: 'assets/Homescreenicons/services.png',
                          ),
                        ],
                      ),
                    )
                  : Container(),
            )
          ],
        ),
      ),
    );
  }
}

class HomeItem extends StatelessWidget {
  final String image;
  final Function ontap;

  const HomeItem({Key key, this.image, this.ontap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Image.asset(image, height: 80, width: 80),
    );
  }
}
