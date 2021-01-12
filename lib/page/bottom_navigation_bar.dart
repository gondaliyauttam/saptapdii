import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:saptapadi/page/homepage.dart';
import 'package:saptapadi/page/inspiation.dart';
import 'package:saptapadi/page/more.dart';
import 'package:saptapadi/page/trending.dart';
import 'package:saptapadi/page/vendors_category.dart';

class Bottomnavigationbar extends StatefulWidget {
  int currenttab;

  Bottomnavigationbar({Key key, this.currenttab}) : super(key: key);
  @override
  _BottomnavigationbarState createState() => _BottomnavigationbarState();
}

class _BottomnavigationbarState extends State<Bottomnavigationbar> {
  Widget currentPage;

  @override
  void initState() {
    super.initState();
    _selectTab(widget.currenttab);
  }

  void _selectTab(int tabItem) {
    setState(() {
      widget.currenttab = tabItem;
      switch (tabItem) {
        case 0:
          currentPage = Vendorscat();
          break;
        case 1:
          currentPage = Trending();
          break;
        case 2:
          currentPage = Home();
          break;
        case 3:
          currentPage = Inspiration();
          break;
        case 4:
          currentPage = More();
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _showDialog,
      child: Scaffold(
        body: currentPage,
        bottomNavigationBar: BottomNavigationBar(
          unselectedFontSize: 15,
          selectedItemColor: Colors.red[900],
          backgroundColor: Colors.grey[300],
          type: BottomNavigationBarType.fixed,
          currentIndex: widget.currenttab,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                backgroundColor: Colors.green,
                icon: Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Image.asset(
                    'assets/home/imgTab1.png',
                    height: 20,
                  ),
                ),
                title: Text('Vendors', style: TextStyle(fontSize: 10)),
                activeIcon: Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Image.asset(
                    'assets/home/imgTab1.png',
                    height: 20,
                    color: Colors.red[900],
                  ),
                )),
            BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Image.asset(
                    'assets/home/imgTab2.png',
                    height: 20,
                  ),
                ),
                title: Text('Trending Today', style: TextStyle(fontSize: 10)),
                activeIcon: Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Image.asset(
                    'assets/home/imgTab2.png',
                    height: 20,
                    color: Colors.red[900],
                  ),
                )),
            BottomNavigationBarItem(
              icon: Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.black)),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Image.asset(
                    'assets/home/imgTab3.png',
                    color: Colors.grey,
                    height: 25,
                  ),
                ),
              ),
              activeIcon: Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.black)),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Image.asset(
                    'assets/home/imgTab3.png',
                    color: Colors.red[900],
                    height: 25,
                  ),
                ),
              ),
              title: Container(),
            ),
            BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Image.asset(
                    'assets/home/imgTab4.png',
                    height: 22,
                  ),
                ),
                title: Text('inspiration', style: TextStyle(fontSize: 10)),
                activeIcon: Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Image.asset(
                    'assets/home/imgTab4.png',
                    height: 22,
                    color: Colors.red[900],
                  ),
                )),
            BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Image.asset(
                    'assets/home/imgTab5.png',
                    height: 20,
                  ),
                ),
                title: Text('more', style: TextStyle(fontSize: 10)),
                activeIcon: Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Image.asset(
                    'assets/home/imgTab5.png',
                    height: 20,
                    color: Colors.red[900],
                  ),
                )),
          ],
          onTap: (int i) {
            this._selectTab(i);
          },
        ),
      ),
    );
  }

  Future<bool> _showDialog() {
    return showDialog(
            context: context,
            barrierDismissible: true,
            builder: (context) {
              return AlertDialog(
                title: Text("Are you sure?"),
                content: Text("You want to exit app"),
                actions: <Widget>[
                  FlatButton(
                    child: Text("Yes"),
                    onPressed: () => Navigator.of(context).pop(true),
                  ),
                  FlatButton(
                    child: Text("No"),
                    onPressed: () => Navigator.of(context).pop(false),
                  )
                ],
              );
            }) ??
        false;
  }
}
