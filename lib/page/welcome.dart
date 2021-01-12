import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:saptapadi/controller/controller.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Welcome extends StatefulWidget {
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends StateMVC<Welcome> {
  Controller _con;
  _WelcomeState() : super(Controller()) {
    _con = controller;
  }
  @override
  void initState() {
    super.initState();
    Controller();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Column(
        children: <Widget>[
          Expanded(
            child: _con.homeScreenBanner != null
                ? Swiper(
                    itemBuilder: (BuildContext context, index) {
                      return CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl: _con.homeScreenBanner[index].upProImg,
                        placeholder: (context, url) => Container(),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      );
                    },
                    itemCount: _con.homeScreenBanner.length,
                    duration: 2000,
                    autoplay: true,
                    pagination: new SwiperPagination(),
                  )
                : Center(child: CircularProgressIndicator()),
          ),
          SizedBox(
            height: 50,
          ),
          Center(
              child: Container(
            child: Image.asset('assets/welcome/logo@3x.png'),
            height: 60,
          )),
          SizedBox(
            height: 30,
          ),
          SizedBox(
            width: 170,
            height: 50,
            child: RaisedButton(
              onPressed: () {
                _con.moveToNext();
                /* Constants.prefs.getBool("loggedin") == true
                    // ? Navigator.of(context).pushReplacementNamed('/HomeScreen')
                    // : Navigator.of(context).pushReplacementNamed('/Register');

                    ? Navigator.pushReplacement(
                        context, SizeRoute(page: HomeScreen()))
                    : Navigator.pushReplacement(
                        context, SizeRoute(page: Register()));*/
              },
              shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(5.0),
                  side: BorderSide(color: Colors.white60)),
              color: Colors.redAccent[700],
              child: Text(
                'GET STARTED',
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
            ),
          ),
          SizedBox(
            height: 30,
          )
        ],
      )),
    );
  }
}
