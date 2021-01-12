import 'package:flutter/material.dart';
import 'package:saptapadi/controller/checklist_controller.dart';
import 'package:saptapadi/utils/app_Images.dart';

class CheckAll extends StatefulWidget {
  CheckController con;

  CheckAll({this.con});

  @override
  _CheckAllState createState() => _CheckAllState();
}

class _CheckAllState extends State<CheckAll> {
  CheckController _con;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _con = widget.con;
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      reverse: false,
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: _con.checklistall.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          child: Padding(
            padding: const EdgeInsets.only(top: 5, bottom: 5, left: 5),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: SizedBox(
                      height: 25,
                      width: 25,
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Image.asset(
                          _con.checklistall[index].checklistDone == "yes"
                              ? check
                              : uncheck,
                        ),
                      )),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(_con.checklistall[index].name),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
