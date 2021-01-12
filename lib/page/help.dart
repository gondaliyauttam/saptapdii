import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:saptapadi/controller/help_controller.dart';
import 'package:saptapadi/page/register.dart';
import 'package:saptapadi/widget/dialogbox.dart';
import 'package:saptapadi/widget/nav.dart';

class Help extends StatefulWidget {
  @override
  _HelpState createState() => _HelpState();
}

class _HelpState extends StateMVC<Help> {
  final FocusNode nameFocus = FocusNode();
  final FocusNode numberFocus = FocusNode();
  final FocusNode emailFocus = FocusNode();
  final FocusNode commentFocus = FocusNode();
  final FocusNode typeFocus = FocusNode();
  String selected;
  HelpController _con;

  _HelpState() : super(HelpController()) {
    _con = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Navbar(
        title: "Help",
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            child: Form(
              key: _con.helpFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'We want to hear from you !',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'if you have any question abot the site or need support,please fill out the form below,and we will respond to your request as quickly as possible.',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    onSaved: (input) => _con.termCondition.name = input,
                    textInputAction: TextInputAction.next,
                    focusNode: nameFocus,
                    onFieldSubmitted: (term) {
                      fieldFocusChange(context, nameFocus, emailFocus);
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter name.';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Name',
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    onSaved: (input) => _con.termCondition.email = input,
                    textInputAction: TextInputAction.next,
                    focusNode: emailFocus,
                    onFieldSubmitted: (term) {
                      fieldFocusChange(context, emailFocus, numberFocus);
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter Email.';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'E-mail',
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    onSaved: (input) => _con.termCondition.mobile = input,
                    textInputAction: TextInputAction.next,
                    focusNode: numberFocus,
                    onFieldSubmitted: (term) {
                      fieldFocusChange(context, numberFocus, commentFocus);
                    },
                    validator: (value) {
                      if (value.length != 10)
                        return 'Mobile Number must be of 10 digit';
                      else
                        return null;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Mobile Number',
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  /*CupertinoButton(
                      child: Text("Select Color :"),
                      onPressed: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return Container(
                                height: 200.0,
                                child: CupertinoPicker(
                                    itemExtent: 32.0,
                                    onSelectedItemChanged: (index) {
                                      print(index);
                                      setState(() {

                                      });
                                    },
                                    children:
                                        ["Bride", "Groom", "Business", "Other"]
                                            .map((label) => Text(label))
                                            .toList(),),
                              );
                            });
                      }),*/
                  DropdownButtonFormField(
                    focusNode: typeFocus,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Select Type';
                      }
                      return null;
                    },
                    onSaved: (input) => _con.termCondition.type = input,
                    value: selected,
                    items: ["Bride", "Groom", "Business", "Other"]
                        .map((label) => DropdownMenuItem(
                              child: Text(label),
                              value: label,
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() => selected = value);
                    },
                    icon: Icon(
                      Icons.keyboard_arrow_down,
                      size: 30,
                    ),
                    hint: Text('Bride/Groom/Other/Business/'),
                    decoration: InputDecoration(border: OutlineInputBorder()),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    onSaved: (input) => _con.termCondition.message = input,
                    textInputAction: TextInputAction.done,
                    focusNode: commentFocus,
                    onFieldSubmitted: (term) {
                      fieldFocusChange(context, commentFocus, commentFocus);
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Enter your question or comment';
                      }
                      return null;
                    },
                    maxLines: 3,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter your question or comment',
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
                          _con.sendInquiry();
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
                  SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 45,
                    child: OutlineButton(
                        child: new Text("About Us"),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return Dialogbox(
                                title: _con.aboutUs.name,
                                description: _con.aboutUs.description,
                              );
                            },
                          );
                        },
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(5.0))),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 45,
                    child: OutlineButton(
                        child: new Text("Terms & Conditions"),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return Dialogbox(
                                title: _con.terms.name,
                                description: _con.terms.description,
                              );
                            },
                          );
                        },
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(5.0))),
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
