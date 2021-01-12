import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:saptapadi/model/register_model.dart';
import 'package:saptapadi/page/homescreen.dart';
import 'package:saptapadi/repository/repository.dart';
import 'package:saptapadi/repository/user_repository.dart';
import 'package:saptapadi/utils/constants.dart';
import 'package:saptapadi/widget/animation.dart';

class Registercontroller extends ControllerMVC {
  Registermodel reg = Registermodel();
  bool isLoading = false;
  GlobalKey<FormState> registerFormKey;
  GlobalKey<ScaffoldState> scaffoldKey;
  String bannerimage = "";

  Registercontroller() {
    this.registerFormKey = new GlobalKey<FormState>();
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
    welcome().then((value) {
      setState(() {
        bannerimage = value.registerScreenBanner.upProImg;
      });
    });
  }

  void registerbutton() async {
    if (registerFormKey.currentState.validate()) {
      registerFormKey.currentState.save();
      register(reg).then((value) =>
      {
        BotToast.showText(
            text: 'Registration Completed Successfully.',
            align: Alignment.center,
            contentColor: Colors.green,
            duration: Duration(seconds: 2)),
        Constants.prefs.setBool("loggedin", true),
        getCurrentUserMobile().then((value) {
          weddingprofile(mobile: value).then((value) {
            setState(() {
              currentUser = value;
              Navigator.pushReplacement(context, SizeRoute(page: HomeScreen()));
            });
          });
        })

      });
    }
  }
}
