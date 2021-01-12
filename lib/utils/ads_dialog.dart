import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:saptapadi/repository/repository.dart';
import 'package:saptapadi/utils/constants.dart';
import 'package:url_launcher/url_launcher.dart';

final locator = GetIt.instance;

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();

  Future<dynamic> navigateTo(String routeName, message) {}

  Showdialog(String upProImg, String url) {
    showDialog(
      barrierDismissible: false,
      barrierColor: Colors.black45,
      context: navigatorKey.currentState.overlay.context,
      builder: (BuildContext context) {
        dialogContext = context;
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.70,
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: Stack(
                children: [
                  InkWell(
                    onTap: () => launchURL(url),
                    child: Image.network(
                      upProImg,
                      fit: BoxFit.fill,
                    //  height: MediaQuery.of(context).size.height * 0.70,
                    //  width: MediaQuery.of(context).size.width,
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: InkWell(
                      child: Padding(
                        padding:
                            const EdgeInsets.only(left: 8.00, bottom: 8.00),
                        child: Icon(
                          Icons.cancel,
                          color: Colors.white,
                        ),
                      ),
                      onTap: () {
                        Navigator.pop(dialogContext);
                        Timer(Duration(seconds: 40), () {
                          if (showTime == 2) {
                          } else {
                            getAds().then((value) {
                              showTime = showTime + 1;
                              locator<NavigationService>().Showdialog(
                                  value.popupScreenBanner.upProImg,
                                  value.popupScreenBanner.url);
                            });
                          }
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );


  }



  launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

void setupLocator() {
  locator.registerLazySingleton(() => NavigationService());
}
