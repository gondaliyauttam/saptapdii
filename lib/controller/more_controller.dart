import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:saptapadi/model/service_data.dart';
import 'package:saptapadi/model/vender_catagory.dart';
import 'package:saptapadi/repository/repository.dart' as repo;
import 'package:saptapadi/repository/repository.dart';

class MoreController extends ControllerMVC{

  GlobalKey<FormState> serviceFormKey;
  List<VendorsCategory> vendorsCategory;
  TextEditingController myController = new TextEditingController();

  ServiceData serviceData=new ServiceData();


  MoreController(){
    serviceFormKey = new GlobalKey<FormState>();
    getVenderCategory();
  }


  sendService(ServiceData serviceData) {
    repo.getService(serviceData).then((value) {
      BotToast.showText(text: value.msg);
    });
  }

  getVenderCategory(){
    vendercatgory().then((value) {
      setState(() {
        vendorsCategory = value.vendorsCategory;
      });
    });
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
      String formattedDate = DateFormat('yyyy-MM-dd').format(date);
      myController.text = formattedDate;
      serviceData.fcDate = formattedDate;
    }
  }

}