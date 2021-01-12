import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:saptapadi/controller/more_controller.dart';
import 'package:saptapadi/page/homepage.dart';
import 'package:saptapadi/page/more.dart';
import 'package:saptapadi/repository/user_repository.dart';
import 'package:saptapadi/widget/animation.dart';
import 'package:saptapadi/widget/nav.dart';

import 'bottom_navigation_bar.dart';

class Service extends StatefulWidget {
  @override
  _ServiceState createState() => _ServiceState();
}

class _ServiceState extends StateMVC<Service> {
  MoreController _con;
  String selected;
  final FocusNode fnOne = FocusNode();
  final FocusNode fnTwo = FocusNode();
  final FocusNode fnThree = FocusNode();
  final FocusNode fnFour = FocusNode();
  final FocusNode fnFive = FocusNode();

  _ServiceState() : super(MoreController()) {
    _con = controller;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        appBar: Navbar(
          title: "Ask the Quote",
          backicon: false,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: _con.serviceFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "You can ask the quote for all vendor by single click.\n Enter your details and click send.",
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    focusNode: fnOne,
                    onFieldSubmitted: (term) {
                      fnOne.unfocus();
                      FocusScope.of(context).requestFocus(fnTwo);
                    },
                    textInputAction: TextInputAction.next,
                    onChanged: (value) => _con.serviceData.name = value,
                    validator: (input) => input.length < 3
                        ? 'Should be more than 3 characters'
                        : null,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Full Name',
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    focusNode: fnTwo,
                    onFieldSubmitted: (term) {
                      fnTwo.unfocus();
                      FocusScope.of(context).requestFocus(fnThree);
                    },
                    textInputAction: TextInputAction.next,
                    onChanged: (value) => _con.serviceData.email = value,
                    validator: (input) =>
                        !input.contains('@') ? "Should be a valid email" : null,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email Address',
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    focusNode: fnThree,
                    onFieldSubmitted: (term) {
                      fnThree.unfocus();
                      FocusScope.of(context).requestFocus(fnFour);
                    },
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    onChanged: (value) => _con.serviceData.mobile = value,
                    validator: (input) => input.length < 10
                        ? 'Should be more than 10 characters'
                        : null,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Mobile Number',
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please select function date';
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
                      labelText: 'Function Date',
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    focusNode: fnFour,
                    onFieldSubmitted: (term) {
                      fnFour.unfocus();
                      FocusScope.of(context).requestFocus(fnFive);
                    },
                    textInputAction: TextInputAction.next,
                    onChanged: (value) => _con.serviceData.city = value,
                    validator: (input) => input.length < 3
                        ? 'Should be more than 3 characters'
                        : null,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'City',
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  _con.vendorsCategory != null
                      ? DropdownButtonFormField(
                          value: selected,
                          items: _con.vendorsCategory
                              .map((label) => DropdownMenuItem(
                                    child: Text(label.name),
                                    value: label.id,
                                  ))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              selected = value;
                              print(value);
                              _con.serviceData.venderCategory = selected;
                            });
                          },
                          icon: Icon(
                            Icons.keyboard_arrow_down,
                            size: 30,
                          ),
                          validator: (value) {
                            if (value == null) {
                              return 'Please select service';
                            }
                            return null;
                          },
                          hint: Text('Service Required'),
                          decoration:
                              InputDecoration(border: OutlineInputBorder()),
                        )
                      : SizedBox(
                          height: 0,
                        ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    focusNode: fnFive,
                    textInputAction: TextInputAction.done,
                    onChanged: (value) => _con.serviceData.budget = value,
                    validator: (input) => input.length < 1
                        ? 'Should be more than 1 characters'
                        : null,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Budget',
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
                          print(selected);
                          if (_con.serviceFormKey.currentState.validate()) {
                            _con.serviceData.userMobile =
                                currentUser.weddingProfile.userMobile;
                            _con.sendService(_con.serviceData);
                          }
                        },
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(5.0),
                            side: BorderSide(color: Colors.white60)),
                        color: Colors.redAccent[700],
                        child: Text(
                          'SEND',
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> _onBackPressed() {
    return Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => Bottomnavigationbar(
                currenttab: 4,
              )),
    );
  }
}
