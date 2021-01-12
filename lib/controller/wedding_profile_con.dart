import 'dart:io';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:saptapadi/model/wedding_profile_data.dart';
import 'package:saptapadi/repository/user_repository.dart' as userRepo;
import 'package:intl/intl.dart';
import 'package:saptapadi/repository/user_repository.dart';

class WeddingController extends ControllerMVC {
  GlobalKey<FormState> profileupdateKey;
  GlobalKey<ScaffoldState> scaffoldKey;
  TextEditingController myController;

  WeddingController() {
    this.profileupdateKey = new GlobalKey<FormState>();
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
    myController = TextEditingController(
        text: userRepo.currentUser.weddingProfile.weddingDate != ""
            ? userRepo.getDate(userRepo.currentUser.weddingProfile.weddingDate)
            : "");
  }

  Future<void> selectDate(BuildContext context) async {
    DateTime date = DateTime(1900);
    FocusScope.of(context).requestFocus(new FocusNode());

    date = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2100));

    if (date != null) {
      String formattedDate = DateFormat('yyyy-MM-dd ').format(date);
      myController.text = formattedDate;
      currentUser.weddingProfile.weddingDate = formattedDate;
    }
  }

  updateProfile(WeddingProfile weddingProfile) {
    userRepo.profileUpdate(weddingProfile).then((value) {
      if (value.statusCode == 1) {
        userRepo
            .weddingprofile(
                mobile: userRepo.currentUser.weddingProfile.userMobile)
            .then((value) {
          userRepo.currentUser = value;
        });
      }
      BotToast.showText(text: value.msg);
    });
  }
}
