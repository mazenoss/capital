import 'package:flutter/material.dart';
import 'package:capital/screens/sign_in.dart';
import 'package:capital/screens/pricing.dart';
import 'package:capital/screens/request.dart';
import 'package:capital/screens/accident.dart';




/*class TabNavigatorRoutes {
  static const String root = '/';
  static const String detail = '/detail';
}*/

class TabNavigator extends StatelessWidget {
  TabNavigator({this.navigatorKey, this.tabItem});
  final GlobalKey<NavigatorState> navigatorKey;
  final String tabItem;

  @override
  Widget build(BuildContext context) {

    Widget child ;
    if(tabItem == "SignIn")
      child = SignIn();
    else if(tabItem == "Pricing")
      child = Pricing();
    else if(tabItem == "Request")
      child = Request();
    else if(tabItem == "Accident")
      child = Accident();

    return Navigator(
      key: navigatorKey,
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(
            builder: (context) => child
        );
      },
    );
  }
}