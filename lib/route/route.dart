import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:saptapadi/page/Exihibition_fair.dart';
import 'package:saptapadi/page/add_check_list.dart';
import 'package:saptapadi/page/bottom_navigation_bar.dart';
import 'package:saptapadi/page/check_tab/check_list.dart';
import 'package:saptapadi/page/custom_check_tab/custom_check_list.dart';
import 'package:saptapadi/page/discount_offer.dart';
import 'package:saptapadi/page/exihibition_details.dart';
import 'package:saptapadi/page/favourite.dart';
import 'package:saptapadi/page/help.dart';
import 'package:saptapadi/page/homepage.dart';
import 'package:saptapadi/page/homescreen.dart';
import 'package:saptapadi/page/inspiation.dart';
import 'package:saptapadi/page/inspiration_details.dart';
import 'package:saptapadi/page/more.dart';
import 'package:saptapadi/page/notification.dart';
import 'package:saptapadi/page/notification_deatails.dart';
import 'package:saptapadi/page/register.dart';
import 'package:saptapadi/page/scratch.dart';
import 'package:saptapadi/page/scratch_%20card.dart';
import 'package:saptapadi/page/service.dart';
import 'package:saptapadi/page/trending.dart';
import 'package:saptapadi/page/treding_details.dart';
import 'package:saptapadi/page/vendor_shortlist/vender_shortlist_main_page.dart';
import 'package:saptapadi/page/vendors_category.dart';
import 'package:saptapadi/page/wedding_profile.dart';
import 'package:saptapadi/page/vendor.dart';
import 'package:saptapadi/page/wedding_venue_details.dart';
import 'package:saptapadi/page/welcome.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/Welcome':
        return MaterialPageRoute(
            builder: (_) => Welcome(),
            settings: RouteSettings(name: '/Welcome'));
      case '/WeddingDetails':
        return MaterialPageRoute(
            builder: (_) => WeddingDetails(
                  vendordetailID: args,
                  vendordetailNAME: args,
                ),
            settings: RouteSettings(name: '/WeddingDetails'));
      case '/WeddingVenue':
        return MaterialPageRoute(
            builder: (_) => Vendors(
                  vendorID: args,
                  vendorNAME: args,
                ),
            settings: RouteSettings(name: '/WeddingVenue'));
      case '/WeddingProfile':
        return MaterialPageRoute(
            builder: (_) => WeddingProfile(),
            settings: RouteSettings(name: '/WeddingProfile'));
      case '/Vendors':
      case '/Vendors':
        return MaterialPageRoute(
            builder: (_) => Vendorscat(),
            settings: RouteSettings(name: '/Vendors'));
      case '/TredingDetails':
        return MaterialPageRoute(
            builder: (_) => TredingDetails(
                  trendingID: args,
                ),
            settings: RouteSettings(name: '/TredingDetails'));
      case '/Trending':
        return MaterialPageRoute(
            builder: (_) => Trending(),
            settings: RouteSettings(name: '/Trending'));
      case '/Service':
        return MaterialPageRoute(
            builder: (_) => Service(),
            settings: RouteSettings(name: '/Service'));
      case '/ScratchCard':
        return MaterialPageRoute(
            builder: (_) => ScratchCardUser(),
            settings: RouteSettings(name: '/ScratchCard'));
      case '/Register':
        return MaterialPageRoute(
            builder: (_) => Register(),
            settings: RouteSettings(name: '/Register'));
      case '/Scratch':
        return MaterialPageRoute(
            builder: (_) => Scratch(),
            settings: RouteSettings(name: '/Scratch'));
      case '/NotificationDetails':
        return MaterialPageRoute(
            builder: (_) => NotificationDetails(
                  nid: args,
                ),
            settings: RouteSettings(name: '/NotificationDetails'));
      case '/Notifications':
        return MaterialPageRoute(
            builder: (_) => Notifications(),
            settings: RouteSettings(name: '/Notifications'));
      case '/More':
        return MaterialPageRoute(
            builder: (_) => More(), settings: RouteSettings(name: '/More'));
      /*   case '/Inspirationdetails':
        return MaterialPageRoute(
            builder: (_) => Inspirationdetails(),
            settings: RouteSettings(name: '/Inspirationdetails'));*/
      case '/Inspiration':
        return MaterialPageRoute(
            builder: (_) => Inspiration(),
            settings: RouteSettings(name: '/Inspiration'));
      case '/HomeScreen':
        return MaterialPageRoute(
            builder: (_) => HomeScreen(),
            settings: RouteSettings(name: '/HomeScreen'));
      case '/Discountoffer':
        return MaterialPageRoute(
            builder: (_) => Discountoffer(),
            settings: RouteSettings(name: '/Discountoffer'));
      case '/Home':
        return MaterialPageRoute(
            builder: (_) => Home(), settings: RouteSettings(name: '/Home'));
      case '/Help':
        return MaterialPageRoute(
            builder: (_) => Help(), settings: RouteSettings(name: '/Help'));
      case '/ExihibitionFair':
        return MaterialPageRoute(
            builder: (_) => ExihibitionFair(),
            settings: RouteSettings(name: '/ExihibitionFair'));
      case '/CheckList':
        return MaterialPageRoute(
            builder: (_) => CheckList(),
            settings: RouteSettings(name: '/CheckList'));
      case '/Bottomnavigationbar':
        return MaterialPageRoute(
            builder: (_) {
              var bottomnavigationbar = Bottomnavigationbar(
                currenttab: args,
              );
              return bottomnavigationbar;
            },
            settings: RouteSettings(name: '/Bottomnavigationbar'));
      case '/AddCheckList':
        return MaterialPageRoute(
            builder: (_) => AddCheckList(
                  routeArgument: args,
                ),
            settings: RouteSettings(name: '/AddCheckList'));
      case '/ExihibitionDetails':
        return MaterialPageRoute(
            builder: (_) => ExihibitionDetails(),
            settings: RouteSettings(name: '/ExihibitionDetails'));

      case '/CustomCheckList':
        return MaterialPageRoute(
            builder: (_) => CustomCheckList(),
            settings: RouteSettings(name: '/CustomCheckList'));
      case '/Favourite':
        return MaterialPageRoute(
            builder: (_) => Favourite(),
            settings: RouteSettings(name: '/CustomCheckList'));

      case '/VendorShortListMainPage':
        return MaterialPageRoute(
            builder: (_) => VendorShortListMainPage(),
            settings: RouteSettings(name: '/VendorShortListMainPage'));
    }
  }
}
