import 'package:capital/screens/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:capital/screens/navi.dart';



class AuthenticationWrapper extends StatelessWidget {
  const AuthenticationWrapper({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
       final firebaseUser = context.watch<User>();
       if(firebaseUser != null){
            return Navi();
       } return SignIn();
  }
}
