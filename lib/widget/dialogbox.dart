import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:html/parser.dart';

class Dialogbox extends StatelessWidget {
  final String title;
  final String description;

  const Dialogbox({
    Key key,
    this.title,
    this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Dialog(
        elevation: 50,
        child: Stack(
          children: [
            Container(
              color: Colors.black.withOpacity(0.9),
              height: 460.0,
              width: 400.0,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: ListView(
                  children: [
                    Text(
                      parseHtmlString(
                        title,
                      ),
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontSize: 14.0,
                        fontFamily: 'lato',
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      parseHtmlString(
                        description,
                      ),
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontFamily: 'lato',
                        fontSize: 14.0,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              right: 1,
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Align(
                  alignment: Alignment.topRight,
                  child: CircleAvatar(
                    radius: 15,
                    backgroundColor: Colors.white70,
                    child: Icon(Icons.close, color: Colors.black),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String parseHtmlString(String htmlString) {
    var document = parse(htmlString);

    String parsedString = parse(document.body.text).documentElement.text;

    return parsedString;
  }
}
