import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:saptapadi/controller/shortlist_controller.dart';
import 'package:saptapadi/page/treding_details.dart';
import 'package:saptapadi/page/wedding_venue_details.dart';
import 'package:url_launcher/url_launcher.dart';

class ShortListPage extends StatefulWidget {
  ShortListController con;

  ShortListPage(this.con);

  @override
  _ShortListPageState createState() => _ShortListPageState();
}

class _ShortListPageState extends State<ShortListPage> {
  ShortListController _con;
  String selected;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _con = widget.con;
    _con.getVendorShortlist();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          _con.vendorsCategory != null
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButtonFormField(
                    isDense: true,
                    value: selected,
                    items: _con.vendorsCategory
                        .map((label) => DropdownMenuItem(
                              child: Text(label.name),
                              value: label.id,
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        selected = value;
                        _con.getVendorShortlist(cid: value);
                        print(value);
                      });
                    },
                    icon: Icon(
                      Icons.keyboard_arrow_down,
                      size: 30,
                    ),
                    validator: (value) {
                      if (value == null) {
                        return 'Please select service';
                      }
                      return null;
                    },
                    hint: Text('By Category'),
                    decoration: InputDecoration(border: OutlineInputBorder()),
                  ),
                )
              : SizedBox(
                  height: 0,
                ),
          _con.vendorSortListData != null
              ? Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: _con.vendorSortListData.vendorsShortlist != null
                        ? _con.vendorSortListData.vendorsShortlist.length
                        : 0,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            PageRouteBuilder(
                              transitionDuration: Duration(milliseconds: 500),
                              pageBuilder: (BuildContext context,
                                  Animation<double> animation,
                                  Animation<double> secondaryAnimation) {
                                return WeddingDetails(
                                  vendordetailID: _con.vendorSortListData
                                      .vendorsShortlist[index].vid,
                                  vendordetailNAME: _con.vendorSortListData
                                      .vendorsShortlist[index].name,
                                  heroTag: "short_list",
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

                          /*  Navigator.push(
            context, SizeRoute(page: TredingDetails(trendingID: trendingID,hero: hero,)));*/
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(5),
                                      child: Hero(
                                        tag: "short_list" +
                                            _con.vendorSortListData
                                                .vendorsShortlist[index].vid,
                                        child: CachedNetworkImage(
                                          imageUrl: _con.vendorSortListData
                                              .vendorsShortlist[index].upProImg,
                                          placeholder: (context, url) => Center(
                                              child:
                                                  CircularProgressIndicator()),
                                          errorWidget: (context, url, error) =>
                                              Icon(Icons.error),
                                          fit: BoxFit.cover,
                                          width: 90,
                                          height: 90,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Expanded(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          _con.vendorSortListData
                                              .vendorsShortlist[index].name,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          _con.vendorSortListData
                                              .vendorsShortlist[index].address,
                                          style: TextStyle(color: Colors.grey),
                                          softWrap: true,
                                          maxLines: 2,
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              new Container(
                                height: 40,
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(3)),
                                    border: Border.all(color: Colors.grey)),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Center(
                                        child: FlatButton.icon(
                                          onPressed: () {
                                            launchURL(
                                                'whatsapp://send?phone=+91 ${_con.vendorSortListData.vendorsShortlist[index].whatsappMobile}');
                                          },
                                          label: Text(
                                            'Chat',
                                            textScaleFactor: 1.1,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          icon: Container(
                                            padding: EdgeInsets.all(2),
                                            child: Image.asset(
                                              'assets/vendor_details/whatsapp.png',
                                              height: 15,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      color: Colors.grey,
                                      width: 1,
                                      height: 50,
                                    ),
                                    Center(
                                      child: FlatButton.icon(
                                        onPressed: () {
                                          _con.addVendorFinalised(
                                              _con.vendorSortListData
                                                  .vendorsShortlist[index].vid,
                                              _con.vendorSortListData
                                                  .vendorsShortlist[index]);
                                        },
                                        label: Text(
                                          'Finalised',
                                          textScaleFactor: 1.1,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        icon: Container(
                                          padding: EdgeInsets.all(2),
                                          child: Image.asset(
                                            'assets/check_list/img2.png',
                                            height: 15,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      color: Colors.grey,
                                      width: 1,
                                      height: 50,
                                    ),
                                    Expanded(
                                      child: Center(
                                        child: FlatButton.icon(
                                          onPressed: () {
                                            launchURL(
                                                'tel:${_con.vendorSortListData.vendorsShortlist[index].contactNo}');
                                          },
                                          label: Text(
                                            'Call',
                                            textScaleFactor: 1.1,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          icon: Container(
                                            padding: EdgeInsets.all(2),
                                            child: Image.asset(
                                              'assets/vendor_details/call.png',
                                              height: 15,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                )
              : Container(),
        ],
      ),
    );
  }

  launchURL(String openURL) async {
    if (await canLaunch(openURL)) {
      await launch(openURL);
    } else {
      throw 'Could not launch $openURL';
    }
  }
}
