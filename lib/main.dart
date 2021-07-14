import 'package:capital/authentication_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:capital/splash.dart';
import 'package:provider/provider.dart';


Future <void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //the past lines must be added if you use firebase
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthenticationService>(
          create: (_) => AuthenticationService(FirebaseAuth.instance),
        ),
        StreamProvider(
            create: (context) => context.read<AuthenticationService>().authStateChanges,
        )      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primaryColor: Color(0xFF2C8CBC),
          scaffoldBackgroundColor: Color(0xFF5FC9FC),
        ),
        home: Splash(),
      ),

    );
  }
}

