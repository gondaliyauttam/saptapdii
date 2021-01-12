import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:saptapadi/controller/checklist_controller.dart';
import 'package:saptapadi/page/custom_check_tab/custom_check_all.dart';
import 'package:saptapadi/page/custom_check_tab/custom_check_done.dart';
import 'package:saptapadi/page/custom_check_tab/custom_check_todo.dart';
import 'package:saptapadi/utils/constants.dart';
import 'package:saptapadi/widget/nav.dart';

class CustomCheckList extends StatefulWidget {
  @override
  _CustomCheckListState createState() => _CustomCheckListState();
}

class _CustomCheckListState extends StateMVC<CustomCheckList>
    with TickerProviderStateMixin {
  TabController _nestedTabController;
  CheckController _con;

  _CustomCheckListState() : super(CheckController()) {
    _con = controller;
  }

  @override
  void initState() {
    super.initState();
    _nestedTabController = new TabController(length: 3, vsync: this);
   _con.getCheckLitdatacustomtodo();
    _con.getCheckLitdatacustomdone();
    _con.getCheckLitdatacustomall();
  }

  @override
  void dispose() {
    super.dispose();
    _nestedTabController.dispose();
  }

  Future<bool> _onWillPop() async {
    Navigator.of(_con.scaffoldKey.currentContext).pop(true);
  }

  @override
  Widget build(BuildContext context) {
    // double screenHeight = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        key: _con.scaffoldKey,
        appBar: Navbar(
            title: 'My Created Check List', elevation: 2, iconButton: false),
        body: Column(
          children: [
            Container(
              height: 60,
              padding: EdgeInsets.only(top: 5),
              alignment: Alignment.center,
              child: RichText(
                text: TextSpan(
                  text: 'You have completed ',
                  style: TextStyle(fontSize: 14, color: Colors.black),
                  children: <TextSpan>[
                    TextSpan(
                        text: customDone.toString() + " ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 18)),
                    TextSpan(
                        text: 'out of ', style: TextStyle(color: Colors.black)),
                    TextSpan(
                        text: customAll.toString() + " ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 18)),
                    TextSpan(
                        text: 'tasks',
                        style: TextStyle(fontSize: 14, color: Colors.black)),
                  ],
                ),
              ),
            ),
            Divider(
              color: Colors.grey,
            ),
            TabBar(
              indicator: BoxDecoration(
                  color: Colors.grey[300],
                  border: Border(
                    bottom: BorderSide(color: Colors.red, width: 2),
                  )),
              controller: _nestedTabController,
              indicatorColor: Colors.red,
              labelColor: Colors.black,
              unselectedLabelColor: Colors.black,
              isScrollable: false,
              tabs: <Widget>[
                Container(
                  height: 100,
                  child: Tab(
                    icon: Image.asset(
                      'assets/check_list/img3.png',
                      height: 40,
                    ),
                    text: "To Do",
                  ),
                ),
                Tab(
                  icon: Image.asset(
                    'assets/check_list/img2.png',
                    height: 40,
                  ),
                  text: "Done",
                ),
                Tab(
                  icon: Image.asset(
                    'assets/check_list/img1.png',
                    height: 40,
                  ),
                  text: "All",
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: Container(
                child: TabBarView(
                  controller: _nestedTabController,
                  children: <Widget>[
                    CustomCheckTodo(
                      con: _con,
                    ),
                    CustomCheckDone(
                      con: _con,
                    ),
                    CustomCheckAll(
                      con: _con,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
