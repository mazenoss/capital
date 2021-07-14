import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:capital/screens/navi.dart';
import 'package:capital/fire_store.dart';
import 'package:email_validator/email_validator.dart';






class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {

  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  String name;
  String phone;
  String email;
  String password;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('home page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 20,),
                TextFormField(
                  onChanged: (value){
                    name = value;
                  },
                  validator: (String value){
                    if(value.isEmpty){
                      return 'please enter yor name';
                    }else if(value.length < 5){
                      return 'name is too short';
                    } return null;
                  },
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      //  borderSide: BorderSide(color: Colors.transparent) ,
                        borderRadius: BorderRadius.all(Radius.circular(10))
                    ),
                    labelText: 'full name',

                  ),

                ),
                SizedBox(height: 10,),
                TextFormField(
                  onChanged: (value){
                    phone = value;
                  },
                  validator: (String value){
                    if(value.isEmpty){
                      return 'please enter yor phone number';
                    }else if(value.length != 11 ){
                      return 'please enter valid phone number';
                    }else if(value.startsWith('01')){
                      return 'enter valid phone number please';
                    } return null;
                  },
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent) ,
                        borderRadius: BorderRadius.all(Radius.circular(10))
                    ),
                    labelText: 'phone number',
                    ),

                ),
                SizedBox(height: 10,),
                TextFormField(
                  onChanged: (value){
                      email = value;
                  },
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
                    labelText: 'email address',
                   ),

                ),
                SizedBox(height: 10,),
                TextFormField(
                  onChanged: (value){
                      password = value;
                  },
                  validator: (String value){
                    if(value.isEmpty){
                      return 'enter your password';
                    }else if (value.length < 5){
                      return 'your password is too short';
                    } return null;
                  },
                  controller: _passwordController,

                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent) ,
                        borderRadius: BorderRadius.all(Radius.circular(10))
                    ),
                    labelText: 'password',

                  ),

                ),
                SizedBox(height: 10,),
                TextFormField(
                  controller: _confirmPasswordController,
                  validator: (String value){
                    if(value.isEmpty){
                      return 'enter your password';
                    }else if (value.length < 5){
                      return 'your password is too short';
                    }else if(value != _passwordController.value.text){
                      return 'password dont match';
                    } return null;
                  },

                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent) ,
                        borderRadius: BorderRadius.all(Radius.circular(10))
                    ),
                    labelText: 'confirm password',
                  ),

                ),
                SizedBox(height: 10),
                Center(
                  child: SizedBox(
                    height: 60,
                    width: 190,
                    child: ElevatedButton(
                      child: Text('signup'),
                      onPressed: () async {
                        if(_formKey.currentState.validate()){

                          final newUser = await _auth.createUserWithEmailAndPassword(
                              email: email, password: password);
                          User updateUser = FirebaseAuth.instance.currentUser;
                          updateUser.updateProfile(displayName: name);
                          userSetup(name, phone, email);
                          if(newUser != null){
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Navi(),
                              ),
                            );
                          }
                       }

                      },
                      style: ElevatedButton.styleFrom(
                          primary: Color(0xFF2C8CBC),
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          textStyle: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
