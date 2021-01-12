
import 'package:saptapadi/repository/user_repository.dart';

class ServiceData {
  String userMobile;
  String name;
  String mobile;
  String email;
  String fcDate;
  String city;
  String venderCategory;
  String budget;


  ServiceData({
    this.userMobile,
    this.name,
    this.email,
    this.fcDate,
    this.city,
    this.mobile,
    this.venderCategory,
    this.budget,
  });



  Map<String, dynamic> toServiceDataJson() => {
    "user_mobile": userMobile,
    "name": name,
    "mobile": mobile,
    "email": email,
    "fc_date": fcDate,
    "city": city,
    "vendor_category": venderCategory,
    "budget": budget,
  };
}
