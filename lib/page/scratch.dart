import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:saptapadi/controller/scarchcard_controller.dart';
import 'package:saptapadi/widget/nav.dart';
import 'package:scratcher/scratcher.dart';
import 'package:url_launcher/url_launcher.dart';

class Scratch extends StatefulWidget {
  @override
  _ScratchState createState() => _ScratchState();
}

class _ScratchState extends StateMVC<Scratch> {
  ScratchCardController _con;

  double brushSize = 50;
  final key = GlobalKey<ScratcherState>();

  _ScratchState() : super(ScratchCardController()) {
    _con = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Navbar(
        title: 'Scratch Card',
        mycartButton: true,
        buttontitle: 'My Gift',
        mycartTap: () {
          Navigator.of(context).pushNamed('/ScratchCard');
        },
      ),
      body: _con.scarchCardData != null
          ? Center(
              child: Column(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _con.scarchCardData.scratchCard != null
                            ? Scratcher(
                                accuracy: ScratchAccuracy.low,
                                key: key,
                                brushSize: brushSize,
                                threshold: 30,
                                color: Colors.grey,
                                onThreshold: () {},
                                onChange: (value) {
                                  setState(() {
                                    if (value > 50) {
                                      key.currentState.reveal(
                                        duration: const Duration(milliseconds: 200),
                                      );
                                      _con.addScratchCarduser(
                                          _con.scarchCardData.scratchCardId);
                                    }
                                    print(value);
                                  });
                                },
                                child: Container(
                                  height: 200,
                                  width: 200,
                                  child: Center(
                                      child: Text(_con.scarchCardData.scratchCard)),
                                ),
                              )
                            : Container(
                                height: 100,
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(_con.scarchCardData.msg,textAlign: TextAlign.center,),
                                  ),
                                ),
                              ),
                        SizedBox(
                          height: 20,
                        ),
                        _con.scarchCardData.scratchCard != null?Text(
                          'Scratch &  Win Gift',
                          style: TextStyle(fontSize: 25),
                        ):SizedBox(height: 0,),
                        SizedBox(height: 40),

                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      _launchURL(_con.scarchCardData.scratchCardBanner.url);
                    },
                    child: CachedNetworkImage(
                      imageUrl: _con.scarchCardData.scratchCardBanner.upProImg,
                    ),
                  ),
                ],
              ),
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}

Future<void> _launchURL(String openURL) async {
  if (await canLaunch(openURL)) {
    await launch(openURL);
  } else {
    throw 'Could not launch $openURL';
  }
}
