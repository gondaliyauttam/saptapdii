import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:saptapadi/model/ads_data.dart';
import 'package:saptapadi/model/homescreenbanner.dart';
import 'package:saptapadi/page/homescreen.dart';
import 'package:saptapadi/page/register.dart';
import 'package:saptapadi/repository/repository.dart';
import 'package:saptapadi/repository/user_repository.dart' as userRepo;
import 'package:saptapadi/utils/constants.dart';
import 'package:saptapadi/widget/animation.dart';

class Controller extends ControllerMVC {
  List<ScreenBanner> homeScreenBanner;
  AdsData adsData;

  @override
  void initState() {
    super.initState();

    welcome().then((value) {
      setState(() {
        homeScreenBanner = value.homeScreenBanner;
      });
    });

    getAds().then((value) {
      adsData = value;
    });



    /*Timer(Duration(seconds: 40), () {
      if (showTime == 2) {
      } else {
        getAds().then((value) {
          showTime = showTime + 1;
          locator<NavigationService>().Showdialog(
              value.popupScreenBanner.upProImg, value.popupScreenBanner.url);
        });
      }
    });*/
  }

/*  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if(state== AppLifecycleState.inactive){
      SystemNavigator.pop();
    }
  }*/
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.inactive:
        print("Inactive");
        break;
      case AppLifecycleState.paused:
        print("Paused");
        SystemNavigator.pop();
        break;
      case AppLifecycleState.resumed:
        print("Resumed");
        break;
      case AppLifecycleState.detached:
        print("Detached");
        // TODO: Handle this case.
        break;
    }
  }

  void moveToNext() {
    if (Constants.prefs.getBool("loggedin") == true) {
      userRepo.getCurrentUserMobile().then((value) {
        userRepo.weddingprofile(mobile: value).then((value) {
          setState(() {
            userRepo.currentUser = value;
            Navigator.pushReplacement(context, SizeRoute(page: HomeScreen()));
          });
        });
      });
    } else {
      Navigator.pushReplacement(context, SizeRoute(page: Register()));
    }
  }

}
