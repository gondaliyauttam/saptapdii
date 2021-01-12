import 'package:flutter/material.dart';
import 'package:saptapadi/controller/checklist_controller.dart';
import 'package:saptapadi/utils/app_Images.dart';

class CheckDone extends StatefulWidget {
  CheckController con;

  CheckDone({this.con});

  @override
  _CheckDoneState createState() => _CheckDoneState();
}

class _CheckDoneState extends State<CheckDone> {
  CheckController _con;

  @override
  void initState() {
    super.initState();
    _con = widget.con;
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      reverse: false,
      scrollDirection: Axis.vertical,
      itemCount: _con.checklistdone.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            _con.removeUserCheckList(_con.checklistdone[index].id);
          },
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
                          check,
                        ),
                      )),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(_con.checklistdone[index].name),
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
