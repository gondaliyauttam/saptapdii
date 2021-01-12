import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:saptapadi/route/route.dart' as route;
import 'package:global_configuration/global_configuration.dart';
import 'package:saptapadi/utils/ads_dialog.dart';
import 'package:saptapadi/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  await GlobalConfiguration().loadFromAsset("configuration");

  WidgetsFlutterBinding.ensureInitialized();
  Constants.prefs = await SharedPreferences.getInstance();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/Welcome',
      onGenerateRoute: route.Router.generateRoute,
      builder: BotToastInit(), //1. call BotToastInit
      navigatorObservers: [BotToastNavigatorObserver()],
      debugShowCheckedModeBanner: false,
      title: 'Saptapadi',
      navigatorKey: locator<NavigationService>().navigatorKey,
      theme: ThemeData(primarySwatch: Colors.green),
      // home: Forgotpassword(),
    );
  }

  // @override
  // void didChangeAppLifecycleState(AppLifecycleState state) {
  //   switch (state) {
  //     case AppLifecycleState.paused:
  //       // print("Inactive");

  //       break;
  //     case AppLifecycleState.resumed:
  //       break;
  //     case AppLifecycleState.inactive:
  //       SystemChannels.platform.invokeMethod<void>('SystemNavigator.pop');
  //       break;
  //     case AppLifecycleState.detached:
  //       break;
  //   }
  // }
}
