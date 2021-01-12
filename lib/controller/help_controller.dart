import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:saptapadi/model/help_model.dart';
import 'package:saptapadi/repository/repository.dart';

class HelpController extends ControllerMVC {
  AboutUs aboutUs;
  Terms terms;
  TermCondition termCondition = TermCondition();
  GlobalKey<FormState> helpFormKey;
  GlobalKey<ScaffoldState> scaffoldKey;

  HelpController() {
    this.helpFormKey = new GlobalKey<FormState>();
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
    termcondition().then((value) {
      setState(() {
        aboutUs = value.aboutUs;
        terms = value.terms;
      });
    });
  }

  void sendInquiry() {
    if (helpFormKey.currentState.validate()) {
      helpFormKey.currentState.save();
      helpsendData(termCondition).then((value) => {
            BotToast.showText(
                text: value.msg,
                align: Alignment.center,
                contentColor: Colors.green,
                duration: Duration(seconds: 3)),
            Navigator.of(context).pushReplacementNamed('/HomeScreen'),
          });
    }
  }
}
