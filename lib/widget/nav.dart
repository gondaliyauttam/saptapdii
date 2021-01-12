import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:saptapadi/widget/mycart.dart';
import 'list_popup.dart';

class Navbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final int elevation;
  final bool iconButton;
  final bool mycartButton;
  final String buttontitle;
  final Function mycartTap;
  final bool backicon;

  const Navbar({
    Key key,
    this.title,
    this.elevation = 0,
    this.iconButton = false,
    this.mycartButton = false,
    this.buttontitle,
    this.mycartTap,
    this.backicon = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      actions: <Widget>[
        iconButton ? Popup() : Container(),
        mycartButton ? MyCart(buttontitle, mycartTap) : Container(),
      ],
      elevation: elevation.toDouble(),
      backgroundColor: Colors.white,
      title: Text(
        title,
        style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.black,
            fontSize: 22,
            fontFamily: 'lato'),
      ),
      leading: InkWell(
        onTap: backicon
            ? () {
                Navigator.of(context).pop(true);
              }
            : null,
        child: backicon
            ? Icon(
                Icons.arrow_back_ios,
                size: 30,
                color: Colors.black,
              )
            : SizedBox(),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<bool>('mycartButton', mycartButton));
    properties.add(DiagnosticsProperty<bool>('mycartButton', mycartButton));
  }
}
