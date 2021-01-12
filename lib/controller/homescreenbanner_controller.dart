import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:saptapadi/model/homescreenbanner.dart';
import 'package:saptapadi/model/menu_banner.dart';
import 'package:saptapadi/model/vender_catagory.dart';
import 'package:saptapadi/repository/repository.dart';

class HomescreenbannerController extends ControllerMVC {
  List<ScreenBanner> homeScreenBanner;

  MenuScreenBanner menuScreenBanner;


  HomescreenbannerController() {
    welcome().then((value) {
      setState(() {
        homeScreenBanner = value.homeScreenBanner;
        // bannerimage = value.registerScreenBanner.upProImg;
      });
    });
    menubanner().then((value) {
      setState(() {
        menuScreenBanner = value.menuScreenBanner;
      });
    });
  }
}
