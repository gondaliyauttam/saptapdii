import 'package:flutter/material.dart';
import 'package:saptapadi/controller/checklist_controller.dart';
import 'package:saptapadi/utils/app_Images.dart';

class CustomCheckAll extends StatefulWidget {
  CheckController con;

  CustomCheckAll({this.con});

  @override
  _CustomCheckAllState createState() => _CustomCheckAllState();
}

class _CustomCheckAllState extends State<CustomCheckAll> {
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
      itemCount: _con.checklistCustomall.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          child: Padding(
            padding: const EdgeInsets.only(top: 5,bottom: 5,left: 4),
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
                          _con.checklistCustomall[index].checklistDone == "yes"
                              ? check
                              : uncheck,
                        ),
                      )),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(_con.checklistCustomall[index].name),
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
