import 'package:flutter/material.dart';
import 'package:saptapadi/controller/checklist_controller.dart';
import 'package:saptapadi/utils/app_Images.dart';

class CustomCheckDone extends StatefulWidget {
  CheckController con;

  CustomCheckDone({this.con});

  @override
  _CustomCheckDoneState createState() => _CustomCheckDoneState();
}

class _CustomCheckDoneState extends State<CustomCheckDone> {
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
      shrinkWrap: true,
      reverse: false,
      scrollDirection: Axis.vertical,
      itemCount: _con.checklistCustomdone.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            _con.removeUserCustomCheckListDone(
                _con.checklistCustomdone[index].checklistId);
          },
          child: Padding(
            padding: const EdgeInsets.only(top: 5, bottom: 5, left: 4),
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
                    child: Text(_con.checklistCustomdone[index].name),
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
