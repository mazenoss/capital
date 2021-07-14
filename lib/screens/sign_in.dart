import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:capital/screens/signup.dart';
import 'package:capital/screens/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:capital/authentication_service.dart';
import 'package:capital/screens/request.dart';
import 'package:email_validator/email_validator.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  String email;
  String password;
  User loggedInUser;
  final TextEditingController  emailController = TextEditingController();
  final TextEditingController  passwordController = TextEditingController();


  @override
  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Home(),
          ),
        );
      }
    }catch(e){
      print(e);
    }
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('home page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 20,),
                TextFormField(
                  validator: (String value){
                    if(value.isEmpty){
                      return 'enter your email address';
                    }else if (!EmailValidator.validate(value)){
                      return 'enter valid email';
                    }return null;
                  } ,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent) ,
                        borderRadius: BorderRadius.all(Radius.circular(10))
                    ),
                    labelText: 'email',
                  ),
                  controller: emailController,
                ),
                SizedBox(height: 20,),
                TextFormField(
                  validator: (String value){
                    if(value.isEmpty){
                      return 'enter your password';
                    }else if (value.length < 5){
                      return 'your password is too short';
                    } return null;
                  },
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent) ,
                        borderRadius: BorderRadius.all(Radius.circular(10))
                    ),
                    labelText: 'password',
                  ),
                 controller: passwordController,

                ),
                SizedBox(height: 10),
                Center(
                  child: SizedBox(
                    height: 60,
                    width: 190,
                    child: ElevatedButton(
                      child: Text('sign in'),
                      onPressed: ()  {
                      if(_formKey.currentState.validate()){
                      context.read<AuthenticationService>().signIn(
                        email: emailController.text.trim(),
                        password: passwordController.text.trim(),
                      );
                      }},
                      style: ElevatedButton.styleFrom(
                          primary: Color(0xFF2C8CBC),
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          textStyle: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),


                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Signup(),
                      ),
                    );

                  },
                  child: Text('get an account now, signup here'),
                ),
               // SizedBox(height:15,),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Request(),
                      ),
                    );

                  },
                  child: Text('Have a question only? ask without registering',style: TextStyle(color: Colors.pink),),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
