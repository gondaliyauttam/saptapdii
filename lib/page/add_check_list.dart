import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:saptapadi/controller/checklist_controller.dart';
import 'package:saptapadi/route/route_argument.dart';
import 'package:saptapadi/widget/nav.dart';

class AddCheckList extends StatefulWidget {
  RouteArgument routeArgument;
  AddCheckList({this.routeArgument});
  @override
  _AddCheckListState createState() => _AddCheckListState();
}

class _AddCheckListState extends StateMVC<AddCheckList> {
  CheckController _con;

  bool fromStart = false;
  String edit_id;

  _AddCheckListState() : super(CheckController()) {
    _con = controller;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fromStart = widget.routeArgument.fromStart;
    if (!fromStart) {
      _con.itemname.text = widget.routeArgument.heroTag;
      edit_id = widget.routeArgument.id;
    }
  }

  Future<bool> _onWillPop() async {
    Navigator.of(_con.scaffoldKey.currentContext).pop(true);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        key: _con.scaffoldKey,
        appBar: Navbar(
          title: 'Check List',
          iconButton: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Text(
                fromStart ? 'Add Check List' : 'Edit Check List',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                maxLines: 4,
                controller: _con.itemname,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              SizedBox(
                height: 40,
                width: 100,
                child: RaisedButton(
                    child: Text(
                      fromStart ? 'Add' : 'Edit',
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Colors.red[800],
                    onPressed: () {
                      if (_con.itemname.text != "") {
                        if (fromStart) {
                          _con.addUserCustomCheckList(_con.itemname.text);
                        } else {
                          _con.updateUserCustomCheckListtodo(
                              edit_id, _con.itemname.text);
                        }
                      } else {
                        BotToast.showText(text: "Please Enter Your Task Name");
                      }
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
