import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:saptapadi/controller/wedding_profile_con.dart';
import 'package:saptapadi/page/register.dart';
import 'package:saptapadi/repository/user_repository.dart';
import 'package:saptapadi/widget/nav.dart';
import 'package:intl/intl.dart';

class WeddingProfile extends StatefulWidget {
  @override
  _WeddingProfileState createState() => _WeddingProfileState();
}

class _WeddingProfileState extends StateMVC<WeddingProfile> {
  final FocusNode groom = FocusNode();
  final FocusNode bride = FocusNode();
  final FocusNode date = FocusNode();
  final FocusNode city = FocusNode();
  final FocusNode mobile = FocusNode();
  WeddingController _con;

  _WeddingProfileState() : super(WeddingController()) {
    _con = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Navbar(
        title: 'Wedding Profile',
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            child: Form(
              key: _con.profileupdateKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Please tell us your self by filling  in the fields below.',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    focusNode: groom,
                    onFieldSubmitted: (term) {
                      fieldFocusChange(context, groom, bride);
                    },
                    initialValue: currentUser.weddingProfile.groomName,
                    onChanged: (input) =>
                        currentUser.weddingProfile.groomName = input,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter Groom name.';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Groom Name',
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    focusNode: bride,
                    onFieldSubmitted: (term) {
                      fieldFocusChange(context, bride, date);
                    },
                    initialValue: currentUser.weddingProfile.brideName,
                    onChanged: (input) =>
                        currentUser.weddingProfile.brideName = input,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter bride name.';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Bride Name',
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    focusNode: date,
                    onFieldSubmitted: (term) {
                      fieldFocusChange(context, date, city);
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please select date.';
                      }
                      return null;
                    },
                    //  initialValue: currentUser.weddingProfile.weddingDate,
                    controller: _con.myController,
                    // controller: dateCtl,
                    onTap: () async {
                      _con.selectDate(context);
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Wedding Date -yyyy/MM/dd',
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    focusNode: city,
                    onFieldSubmitted: (term) {
                      fieldFocusChange(context, city, mobile);
                    },
                    initialValue: currentUser.weddingProfile.city,
                    onChanged: (input) =>
                        currentUser.weddingProfile.city = input,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter city.';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Your City ',
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    textInputAction: TextInputAction.done,
                    focusNode: mobile,
                    validator: (value) {
                      if (value.length != 10)
                        return 'Mobile Number must be of 10 digit';
                      else
                        return null;
                    },
                    initialValue: currentUser.weddingProfile.mobile,
                    onChanged: (input) =>
                        currentUser.weddingProfile.mobile = input,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Mobile Number ',
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Center(
                    child: SizedBox(
                      height: 45,
                      width: 100,
                      child: RaisedButton(
                        onPressed: () {
                          _con.updateProfile(currentUser);
                        },
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(5.0),
                            side: BorderSide(color: Colors.white60)),
                        color: Colors.redAccent[700],
                        child: Text(
                          'Save',
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
