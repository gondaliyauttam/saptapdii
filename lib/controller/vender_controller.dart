import 'package:bot_toast/bot_toast.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:saptapadi/model/vender_catagory.dart';
import 'package:saptapadi/repository/repository.dart';

class VendorsController extends ControllerMVC {
  List<VendorsCategory> vendorsCategory;

  // List<VendorsGallery> vendorsGallery;
  List<VendorsBanner> vendorsBanner;

  Vender vendor;
  VenderDetails venderdetail;

  VendorsController() {
    vendercatgory().then((value) {
      setState(() {
        vendorsCategory = value.vendorsCategory;
      });
    });
  }

  getVendorDetail(String cID) {
    getvender(cID).then((value) {
      setState(() {
        vendor = value;
        vendorsBanner = value.vendorsBanner;
      });
    });
  }

  getVendorDetailother(String vID) {
    getVenderDetails(vID).then((value) {
      setState(() {
        venderdetail = value;
      });
    });
  }

  void addvendershortlist(vId) async {
    addVendorShortlist(vId).then((value) {
      BotToast.showText(text: value.msg);
      if (value.statusCode == 1) {
        if(vendor!=null){
          vendor.vendorsList.forEach((element) {
            if (element.id == vId) {
              setState(() {
                element.vendorShortlist = "yes";
              });
            }
          });
        }

        if(venderdetail!=null){
          setState((){
            venderdetail.vendorShortlist="yes";
          });
        }

      }
    });
  }

  void removevendershortlist(vId) async {
    removeVendorShortlist(vId).then((value) {
      BotToast.showText(text: value.msg);
      if (value.statusCode == 1) {
        if(vendor!=null){
          vendor.vendorsList.forEach((element) {
            if (element.id == vId) {
              setState(() {
                element.vendorShortlist = "";
              });
            }
          });
        }

        if(venderdetail!=null){
          setState((){
            venderdetail.vendorShortlist="";
          });
        }




      }
    });
  }
}
