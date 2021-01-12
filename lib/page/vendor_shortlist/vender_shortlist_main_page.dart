import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:saptapadi/controller/shortlist_controller.dart';
import 'package:saptapadi/page/vendor_shortlist/finalised_page.dart';
import 'package:saptapadi/page/vendor_shortlist/shortList_page.dart';
import 'package:saptapadi/widget/nav.dart';

class VendorShortListMainPage extends StatefulWidget {
  @override
  _VendorShortListMainPageState createState() =>
      _VendorShortListMainPageState();
}

class _VendorShortListMainPageState extends StateMVC<VendorShortListMainPage>
    with TickerProviderStateMixin {
  TabController _nestedTabController;

  ShortListController _con;

  _VendorShortListMainPageState() : super(ShortListController()) {
    _con = controller;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nestedTabController = new TabController(length: 2, vsync: this);
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
        appBar:
            Navbar(title: 'Vendor Shortlists', elevation: 2, iconButton: false),
        body: Container(
          child: Column(
            children: [
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
                  Tab(
                    text: "Shortlists",
                  ),
                  Tab(
                    text: "Finalised",
                  ),
                ],
              ),
              Expanded(
                child: Container(
                  child: TabBarView(
                    controller: _nestedTabController,
                    children: <Widget>[
                      ShortListPage(_con),
                      FinalisedPage(_con),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
