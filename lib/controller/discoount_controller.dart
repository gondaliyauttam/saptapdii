import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:saptapadi/model/discount_model.dart';
import 'package:saptapadi/repository/repository.dart';

class Discountcontroller extends ControllerMVC {
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  bool isLoading = true;
  DiscountData discountData;
  Discountcontroller() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();

    discount_offer().then((value) {
      setState(() {
        discountData = value;
        if (value.statusCode == 0) {
          scaffoldKey.currentState.showSnackBar(SnackBar(
            content: Container(
              height: 20,
              child: Center(
                child: Text(value.msg),
              ),
            ),
            duration: Duration(
              minutes: 2,
            ),
          ));
          // BotToast.showText(
          //     text: dis.msg,
          //     align: Alignment.center,
          //     contentColor: Colors.black,
          //     duration: Duration(seconds: 5));
        }
        isLoading = false;
      });
    });
  }
}
