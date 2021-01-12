import 'package:flutter/material.dart';
import 'package:saptapadi/controller/checklist_controller.dart';
import 'package:saptapadi/controller/home_page_controller.dart';
import 'package:saptapadi/utils/app_Images.dart';

class CheckTodo extends StatefulWidget {
  CheckController con;

  CheckTodo({this.con});

  @override
  _CheckTodoState createState() => _CheckTodoState();
}

class _CheckTodoState extends State<CheckTodo> {
  CheckController _con;

  @override
  void initState() {
    super.initState();
    _con = widget.con;
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      reverse: false,
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: _con.checklisttodo.length,
      itemBuilder: (context, index) {
        return GestureDetector(
            onTap: () {
              _con.addUserCheckList(_con.checklisttodo[index].id);
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
                            uncheck,
                          ),
                        )),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(_con.checklisttodo[index].name),
                    ),
                  )
                ],
              ),
            ));
      },
    );
  }
}
