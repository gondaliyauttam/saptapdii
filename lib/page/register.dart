import 'package:bot_toast/bot_toast.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:saptapadi/controller/register_controller.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends StateMVC<Register> {
  var namecontroller = TextEditingController();
  var numbercontroller = TextEditingController();
  var citycontroller = TextEditingController();
  final FocusNode nameFocus = FocusNode();
  final FocusNode numberFocus = FocusNode();
  final FocusNode cityFocus = FocusNode();
  Registercontroller _con;
  _RegisterState() : super(Registercontroller()) {
    _con = controller;
  }

  bool _value = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // resizeToAvoidBottomInset: false,
        // backgroundColor: Colors.black,
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            _con.bannerimage != ""
                ? CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: _con.bannerimage,
                    placeholder: (context, url) => Container(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  )
                : Center(child: CircularProgressIndicator()),
            Container(
              // color: Colors.red,
              child: Column(
                children: [
                  Expanded(child: Container()),
                  Center(
                    child: Padding(
                      padding:
                          const EdgeInsets.only(bottom: 1, right: 10, left: 10),
                      child: Column(
                        children: <Widget>[
                          Card(
                            child: Form(
                                key: _con.registerFormKey,
                                child: Column(
                                  children: <Widget>[
                                    TextFormField(
                                      textInputAction: TextInputAction.next,
                                      focusNode: nameFocus,
                                      onSaved: (input) => _con.reg.name = input,
                                      onFieldSubmitted: (term) {
                                        fieldFocusChange(
                                            context, nameFocus, numberFocus);
                                      },
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'Please enter name.';
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                          icon: Image.asset(
                                            'assets/register/imgName.png',
                                            height: 20,
                                            width: 30,
                                          ),
                                          hintText: "Name",
                                          labelText: "Name"),
                                    ),
                                    TextFormField(
                                      keyboardType: TextInputType.number,
                                      textInputAction: TextInputAction.next,
                                      onSaved: (input) =>
                                          _con.reg.mobile = input,
                                      focusNode: numberFocus,
                                      onFieldSubmitted: (term) {
                                        fieldFocusChange(
                                            context, numberFocus, cityFocus);
                                      },
                                      validator: (value) {
                                        if (value.length != 10)
                                          return 'Mobile Number must be of 10 digit';
                                        else
                                          return null;
                                      },
                                      decoration: InputDecoration(
                                        icon: Image.asset(
                                          'assets/register/imgMobile.png',
                                          height: 20,
                                          width: 30,
                                        ),
                                        hintText: "Mobile Number",
                                        labelText: "Number",
                                      ),
                                    ),
                                    TextFormField(
                                      textInputAction: TextInputAction.done,
                                      onSaved: (input) => _con.reg.city = input,
                                      focusNode: cityFocus,
                                      onFieldSubmitted: (term) {
                                        fieldFocusChange(
                                            context, cityFocus, cityFocus);
                                      },
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'Please enter city.';
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                        icon: Image.asset(
                                          'assets/register/imgCity.png',
                                          height: 20,
                                          width: 30,
                                        ),
                                        hintText: "City",
                                        labelText: "City",
                                      ),
                                    ),
                                  ],
                                )),
                          ),
                          Row(
                            children: <Widget>[
                              Theme(
                                data: ThemeData(
                                    unselectedWidgetColor: Colors.white),
                                child: Checkbox(
                                  checkColor: Colors.white,
                                  activeColor:
                                      _value ? Colors.green : Colors.red,
                                  value: _value,
                                  onChanged: (bool newValue) {
                                    setState(() {
                                      _value = newValue;
                                    });
                                  },
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  // showDialog(
                                  //   context: context,
                                  //   builder: (context) {
                                  //     return Dialogbox(
                                  //       title: _con.terms.name,
                                  //       description: _con.terms.description,
                                  //     );
                                  //   },
                                  // );
                                },
                                child: RichText(
                                  text: TextSpan(
                                    text: 'I agree to the ',
                                    style: TextStyle(fontSize: 14),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: 'Terms of Service',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.redAccent)),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          ButtonTheme(
                              minWidth: 125,
                              height: 50,
                              child: RaisedButton(
                                shape: new RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(5.0),
                                    side: BorderSide(color: Colors.white60)),
                                onPressed: () {
                                  if (_value == false) {
                                    BotToast.showText(
                                        text:
                                            'you must agree terms and conditions',
                                        align: Alignment.center,
                                        contentColor: Colors.red[800],
                                        duration: Duration(seconds: 2));
                                  } else {
                                    _con.registerbutton();
                                  }
                                },
                                color: Colors.redAccent[700],
                                child: Text(
                                  'Sign Up',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )),
                          SizedBox(
                            height: 10,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

fieldFocusChange(
    BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
  currentFocus.unfocus();
  FocusScope.of(context).requestFocus(nextFocus);
}
