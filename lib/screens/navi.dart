import 'package:flutter/material.dart';
import 'package:capital/screens/home.dart';
import 'package:capital/screens/pricing.dart';
import 'package:capital/screens/request.dart';
import 'package:capital/screens/accident.dart';
import 'package:custom_navigator/custom_scaffold.dart';
import 'package:capital/screens/policies.dart';




class Navi extends StatefulWidget {
  @override
  _NaviState createState() => _NaviState();
}


class _NaviState extends State<Navi>{

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(

      scaffold: Scaffold(

        bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                activeIcon: Icon(Icons.home,color: Color(0xFF042C40),size: 60,),
                icon: Icon(Icons.home,color: Color(0xFF2C8CBC),size: 40,),
                title: Text('Home',style: TextStyle(color: Color(0xFF2C8CBC))),

              ),
              BottomNavigationBarItem(
                activeIcon: Icon(Icons.monetization_on,color: Color(0xFF042C40),size: 60,),

                icon: Icon(Icons.monetization_on,color: Color(0xFF2C8CBC),size: 40,),
                title: Text('Pricing',style: TextStyle(color: Color(0xFF2C8CBC))),
              ),

              BottomNavigationBarItem(
                activeIcon: Icon(Icons.time_to_leave,color: Color(0xFF042C40),size: 60,),
                icon: Icon(Icons.time_to_leave,color: Color(0xFF2C8CBC),size: 40,),
                title: Text('accident',style: TextStyle(color: Color(0xFF2C8CBC)),),
               ),

            ],
        ),
      ),
      children: <Widget>[
        Home(),
        Pricing(),

        Accident(),
      ],

    );

  }


}