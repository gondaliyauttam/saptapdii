import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:saptapadi/model/exhibition_model.dart';
import 'package:saptapadi/model/exibition_detail_data.dart';
import 'package:saptapadi/repository/repository.dart';

class ExhibitionController extends ControllerMVC {
  bool isLoading = true;
  ExhibitionData exhibitionData;
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  ExhibitionDetailData exhibitionDetailData;

  ExhibitionController() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
    getExibitionList();
  }

  void getExibitionList() async {
    exihibition().then((value) {
      setState(() {
        exhibitionData = value;

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
        }
        isLoading = false;
      });
    });
  }

  void getExhibitionDetails(eid) async {
    exihibitionDetails(eid).then((value) {
      setState(() {
        exhibitionDetailData = value;
      });
    });
  }
}
