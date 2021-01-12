import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:saptapadi/model/success_data.dart';
import 'package:saptapadi/model/vender_catagory.dart';
import 'package:saptapadi/model/vendor_finalised_data.dart';
import 'package:saptapadi/model/vendor_shortlist_data.dart';
import 'package:saptapadi/repository/check_repository.dart';
import 'package:saptapadi/repository/repository.dart';

class ShortListController extends ControllerMVC {
  List<VendorsCategory> vendorsCategory=new List<VendorsCategory>();
  VendorSortListData vendorSortListData;
  VendorFinalisedData vendorFinalisedData;
  GlobalKey<ScaffoldState> scaffoldKey;

  ShortListController() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
    getVenderCategory();
  }

  getVenderCategory() {
    vendercatgory().then((value) {
      setState(() {
        vendorsCategory = value.vendorsCategory;
        VendorsCategory v= new VendorsCategory(id: "",name: "All",upProImg:"");
        vendorsCategory.insert(0,v);
      });
    });
  }

  getVendorShortlist({cid}) {
    getVendorShortList(cid: cid).then((value) {
      setState(() {
        vendorSortListData = value;
      });
      if(value.statusCode==0){
        BotToast.showText(text: value.msg);
      }
    });
  }

  getVendorFinalised({cid}) {
    getVendorSFinalised(cid: cid).then((value) {
      setState(() {
        vendorFinalisedData = value;
      });
      if(value.statusCode==0){
        BotToast.showText(text: value.msg);
      }
    });
  }

  addVendorFinalised(vid, VendorsShortlist vendorsShortlist) async {
    SuccessData successData = await addvendorfinalised(vid);
    if (successData.statusCode == 1) {
      vendorSortListData.vendorsShortlist
          .removeWhere((element) => element.vid == vid);
      notifyListeners();
    }
    BotToast.showText(text: successData.msg);
  }

  removeVendorFinalised(vid, VendorsShortlist vendorsShortlist) async {
    SuccessData successData = await removevendorfinalised(vid);
    if (successData.statusCode == 1) {
      vendorFinalisedData.vendorsShortlist
          .removeWhere((element) => element.vid == vid);
      notifyListeners();
    }
    BotToast.showText(text: successData.msg);
  }
}
