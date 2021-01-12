import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:saptapadi/model/inspiration_detail_data.dart';
import 'package:saptapadi/model/inspiration_model.dart';
import 'package:saptapadi/repository/repository.dart';

class InspirationController extends ControllerMVC {
  InspirationData inspirationData;
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  InspirationDetailData inspirationDetailData;

  bool isLoading = true;

  InspirationController() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
    getInspirationalData();
  }

  void getInspirationalData() async {
    inspirations().then((value) {
      setState(() {
        inspirationData = value;
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

  void getInspirationDetailData(iId) async {
    inspirationsDetail(iId).then((value) {
      setState(() {
        inspirationDetailData = value;
        isLoading = false;
      });
    });
  }
}
