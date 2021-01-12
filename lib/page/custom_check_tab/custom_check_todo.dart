import 'package:flutter/material.dart';
import 'package:saptapadi/controller/checklist_controller.dart';
import 'package:saptapadi/utils/app_Images.dart';

class CustomCheckTodo extends StatefulWidget {
  CheckController con;

  CustomCheckTodo({this.con});

  @override
  _CustomCheckTodoState createState() => _CustomCheckTodoState();
}

class _CustomCheckTodoState extends State<CustomCheckTodo> {
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
      itemCount: _con.checklistCustomtodo.length,
      itemBuilder: (context, index) {
        return GestureDetector(
                onTap: () {
                  _con.addUserCustomCheckListdone(
                      _con.checklistCustomtodo[index].checklistId);
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 5, bottom: 5, left: 5),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
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
                          child: Text(_con.checklistCustomtodo[index].name),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          _con.openEditPage(
                              _con.checklistCustomtodo[index].checklistId,
                              _con.checklistCustomtodo[index].name);
                          //      Navigator.of(context).pushNamed('/AddCheckList',arguments: new RouteArgument(id: _con.checklistCustomtodo[index].checklistId,fromStart: false,heroTag: _con.checklistCustomtodo[index].name ));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                              height: 20,
                              width: 20,
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Image.asset(
                                  edit,
                                ),
                              )),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Center(child: Text("Saptapadi")),
                                  content: Text(
                                    "Are you sure want to remove this check list?",
                                    textAlign: TextAlign.justify,
                                  ),
                                  actions: <Widget>[
                                    FlatButton(
                                      child: Text("Yes"),
                                      onPressed: () =>
                                          _con.removeUserCheckListCustom(_con
                                              .checklistCustomtodo[index]
                                              .checklistId),
                                    ),
                                    FlatButton(
                                      child: Text("No"),
                                      onPressed: () =>
                                          Navigator.of(context).pop(false),
                                    )
                                  ],
                                );
                              });
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                              height: 20,
                              width: 20,
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Image.asset(
                                  delete,
                                ),
                              )),
                        ),
                      ),
                    ],
                  ),
                )) ??
            false;
      },
    );
  }
}
