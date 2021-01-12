import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:saptapadi/model/scrachcard_data.dart';
import 'package:saptapadi/model/scratchcard_user_data.dart';
import 'package:saptapadi/repository/repository.dart' as repo;

class ScratchCardController extends ControllerMVC {
  ScarchCardData scarchCardData;
  ScratchCardUserData scratchCardUserData;

  ScratchCardController() {
    getScratchCardbanner();
  }

  void getScratchCardbanner() async {
    repo.getScrachcardandBanner().then((value) async {
      print(value);
      setState(() {});
      scarchCardData = value;
    });
  }

  void getScratchCarduser() async {
    repo.getScratchcardUser().then((value) async {
      print(value);
      setState(() {});
      scratchCardUserData = value;
    });
  }

  void addScratchCarduser(sid) async {
    repo.addScrachcardUser(sid).then((value) {
      BotToast.showText(text: value.msg);
    });
  }

  void scratchcardverify(gId,scId,code)async{
   repo.getScratchVerify(gId,scId,code).then((value) {
     BotToast.showText(text: value.msg);
     getScratchCarduser();
     Navigator.of(context).pop();

   });
  }
}
