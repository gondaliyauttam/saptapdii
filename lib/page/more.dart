import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:saptapadi/page/favourite.dart';
import 'package:saptapadi/page/wedding_profile.dart';
import 'package:saptapadi/repository/user_repository.dart';
import 'package:saptapadi/utils/constants.dart';
import 'package:saptapadi/widget/animation.dart';
import '../repository/user_repository.dart';
import 'Exihibition_fair.dart';
import 'help.dart';
import 'service.dart';
import 'package:share/share.dart';
import 'package:store_redirect/store_redirect.dart';

class More extends StatefulWidget {
  @override
  _MoreState createState() => _MoreState();
}

class _MoreState extends State<More> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),
            Container(
              height: 120,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: SizedBox(
                      child: ClipOval(
                        child: image != null
                            ? Image.file(
                                image,
                                fit: BoxFit.cover,
                              )
                            : CachedNetworkImage(
                                width: 100,
                                imageUrl:
                                    currentUser.weddingProfile.upProImg != null
                                        ? currentUser.weddingProfile.upProImg
                                        : "",
                                fit: BoxFit.cover,
                                placeholder: (context, url) => Center(
                                    child: SizedBox(
                                        height: 50,
                                        width: 50,
                                        child:
                                            const CircularProgressIndicator())),
                                errorWidget: (context, url, error) =>
                                    Image.asset(
                                  'assets/home/imgDashboard.jpg',
                                  fit: BoxFit.cover,
                                ),
                                fadeOutDuration: const Duration(seconds: 1),
                                fadeInDuration: const Duration(seconds: 3),
                              ),
                        /* Image.network(
                                'https://images.unsplash.com/photo-1555952517-2e8e729e0b44?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=400&q=80',
                                fit: BoxFit.cover,
                              ),*/
                      ),
                      height: 125,
                      width: 125,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        currentUser.weddingProfile.groomName +
                            " " +
                            currentUser.weddingProfile.brideName,
                        textScaleFactor: 2,
                        style: TextStyle(fontFamily: 'Pacifico'),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      InkWell(
                        onTap: () {
                          // Navigator.of(context).pushNamed('/WeddingProfile');
                          Navigator.push(
                              context, SizeRoute(page: WeddingProfile()));
                        },
                        child: Text(
                          'Edit Profile',
                          textScaleFactor: 1.2,
                          style: TextStyle(fontFamily: 'lato'),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Divider(
              color: Colors.grey,
            ),
            Expanded(
              child: ListView(
                children: [
                  MenuItem(
                    title: 'Exihibition & Fair',
                    image: 'assets/menu/imgMenu2.png',
                    ontap: () {
                      Navigator.push(
                          context, SizeRoute(page: ExihibitionFair()));
                    },
                  ),
                  Divider(
                    color: Colors.grey,
                  ),
                  MenuItem(
                    title: 'Ask the Quote',
                    image: 'assets/menu/imgMenu1.png',
                    ontap: () {
                      Navigator.push(context, SizeRoute(page: Service()));
                    },
                  ),
                  Divider(
                    color: Colors.grey,
                  ),
                  MenuItem(
                    title: 'Favourites',
                    image: 'assets/menu/imgMenu3.png',
                    ontap: () {
                      Navigator.push(context, SizeRoute(page: Favourite()));
                    },
                  ),
                  Divider(
                    color: Colors.grey,
                  ),
                  MenuItem(
                    title: 'Help',
                    image: 'assets/menu/imgMenu4.png',
                    ontap: () {
                      Navigator.push(context, SizeRoute(page: Help()));
                    },
                  ),
                  Divider(
                    color: Colors.grey,
                  ),
                  MenuItem(
                    title: 'Rate Our App',
                    image: 'assets/menu/imgMenu5.png',
                    ontap: () {
                      StoreRedirect.redirect(
                          androidAppId: "com.saptapadi&hl=en");
                    },
                  ),
                  Divider(
                    color: Colors.grey,
                  ),
                  MenuItem(
                    title: 'Share the App',
                    image: 'assets/menu/imgMenu6.png',
                    ontap: () {
                      Share.share('check out my website https://google.com');
                    },
                  ),
                  // Divider(
                  //   color: Colors.grey,
                  // ),
                  // MenuItem(
                  //   title: 'Log Out',
                  //   image: 'assets/menu/logout.png',
                  //   ontap: () {
                  //     Constants.prefs.setBool("loggedin", false);
                  //     Navigator.of(context).pushReplacementNamed('/Register');
                  //   },
                  // )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MenuItem extends StatelessWidget {
  final String title;
  final String image;
  final Function ontap;

  const MenuItem({Key key, this.title, this.image, this.ontap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: ontap,
      leading: Image.asset(
        image,
        height: 30,
        width: 30,
      ),
      title: Text(
        title,
        style: TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 20,
            color: Colors.black54,
            fontFamily: 'lato'),
      ),
    );
  }
}
