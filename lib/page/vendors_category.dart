import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:saptapadi/controller/vender_controller.dart';
import 'package:saptapadi/page/vendor.dart';
import 'package:saptapadi/widget/nav.dart';

class Vendorscat extends StatefulWidget {
  @override
  _VendorscatState createState() => _VendorscatState();
}

class _VendorscatState extends StateMVC<Vendorscat> {
  VendorsController _con;
  _VendorscatState() : super(VendorsController()) {
    _con = controller;
  }
  @override
  Widget build(BuildContext context) {
    return _myListView(context);
  }

  Widget _myListView(BuildContext context) {
    return Scaffold(
      appBar: Navbar(
        title: 'Vendors',
        backicon: false,
      ),
      body: _con.vendorsCategory != null
          ? GridView.builder(
              padding: const EdgeInsets.all(4.0),
              scrollDirection: Axis.vertical,
              itemCount: _con.vendorsCategory.length,
              gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, childAspectRatio: 1.2),
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        PageRouteBuilder(
                          transitionDuration: Duration(milliseconds: 500),
                          pageBuilder: (BuildContext context,
                              Animation<double> animation,
                              Animation<double> secondaryAnimation) {
                            return Vendors(
                              vendorID: _con.vendorsCategory[index].id,
                              vendorNAME: _con.vendorsCategory[index].name,
                            );
                          },
                          transitionsBuilder: (BuildContext context,
                              Animation<double> animation,
                              Animation<double> secondaryAnimation,
                              Widget child) {
                            return Align(
                              child: FadeTransition(
                                opacity: animation,
                                child: child,
                              ),
                            );
                          },
                        ),
                      );
                      // Navigator.push(
                      //     context,
                      //     SizeRoute(
                      //         page: Vendors(
                      //       vendorID: _con.vendorsCategory[index].id,
                      //       vendorNAME: _con.vendorsCategory[index].name,
                      //       heroName: "vender_category",
                      //     )));
                    },
                    child: Container(
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl: _con.vendorsCategory[index].upProImg,
                            placeholder: (context, url) =>
                                Center(child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          )),
                    ),
                  ),
                );
              },
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
