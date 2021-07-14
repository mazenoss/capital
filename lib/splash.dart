import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:capital/authentication_wrapper.dart';


class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  // ignore: missing_return
  Widget build(BuildContext context) {

    return Container(
      width:0,
       height: 0,
       child: SplashScreen(
          gradientBackground: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color(0xFF5FC9FC),
              Color(0xFF2C8CBC),
            ],
          ),
          seconds: 5,
          navigateAfterSeconds: AuthenticationWrapper(),
          loaderColor: Color(0xFF2C8CBC),
          photoSize: 150.0,
          image: new Image.asset(
              'images/logo_capital-ai.png'),
        ),
     );

  }

}
