import 'package:flutter/material.dart';
import 'package:saptapadi/route/route_argument.dart';

class Popup extends StatelessWidget {
  const Popup({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      onSelected: (result) {
        if (result == 0) {
          Navigator.of(context).pushNamed('/AddCheckList',arguments: new RouteArgument(fromStart: true));
        } else if (result == 1) {
          Navigator.of(context).pushNamed('/CustomCheckList');
        }
      },
      icon: Icon(
        Icons.menu,
        color: Colors.black,
        size: 35,
      ),
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 0,
          child: Text('Add Check List'),
        ),
        PopupMenuItem(
          value: 1,
          child: Text('My Created Chek List'),
        ),
      ],
    );
  }
}
