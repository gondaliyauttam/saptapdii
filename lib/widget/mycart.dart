import 'package:flutter/material.dart';

class MyCart extends StatelessWidget {
  String buttontitle;
  Function mycartTap;
  MyCart(this.buttontitle, this.mycartTap);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Text(
          buttontitle,
          style: TextStyle(color: Colors.white),
        ),
        color: Colors.red[800],
        onPressed: mycartTap,
      ),
    );
  }
}
