import 'package:flutter/material.dart';
import 'package:capital/screens/home.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:capital/fire_store.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



class Pricing extends StatefulWidget {
  @override
  _PricingState createState() => _PricingState();
}

class _PricingState extends State<Pricing> {

  String uid = FirebaseAuth.instance.currentUser.uid.toString();
  QuerySnapshot name;
  User user;
  Crud crudName = new Crud();
  final auth = FirebaseAuth.instance;
  Future<void> getUserData() async{
    User userData = await FirebaseAuth.instance.currentUser;
    setState(() {
      user = userData;
    });
  }

  String type;
  String detail;

  List listItem = [
    'Life', 'Cars', 'Marine', 'Industrial'
  ];

  @override
  void initState() {
    super.initState();
    getUserData();
    crudName.getName().then((data){
      setState(() {
        name = data;
      });
    });
  }
  sendMail() async {


    String username = 'mazenoss@gmail.com';
    String password = 'Newm@zen1';

    final smtpServer = gmail(username, password);

    final message = Message()
      ..from = Address(username, '${name.docs[0].data()['name']}')
      ..recipients.add('mazenoss@gmail.com')
      ..attachments = []
      ..subject = 'Pricing request from ${name.docs[0].data()['name']} '
      ..text = 'name: ${name.docs[0].data()['name']}\nphone: ${name.docs[0].data()['phone']}\nInsurance type: ${type}\n---------------\n${detail}' ;

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
    } on MailerException catch (e) {
      print('Message not sent.');
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    }

  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ask for pricing'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              
              SizedBox(width: 15,),

              Text('Insurance type',style: TextStyle(color: Color(0xFF1C6494), fontSize:20 ),),
              Container(
                decoration: BoxDecoration(
                  color: Color(0xFF2C8CBC),
                  borderRadius: BorderRadius.circular(10),

                ),
                child: DropdownButtonHideUnderline(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10,0,0,0),
                      child: DropdownButton(
                        dropdownColor: Color(0xFF2C8CBC),
                        hint: Text('choose',style: TextStyle(color: Colors.white),),
                        value: type,
                        onChanged: (newValue){
                          setState(() {
                            type = newValue;
                          });
                        },
                        items: listItem.map((valueItem){
                          return DropdownMenuItem(
                            value: valueItem,
                            child: Text(valueItem,style: TextStyle(color: Colors.white)),
                          );
                        }).toList(),
                      )

                    ) ,

                )

              ),

              SizedBox(height: 10),
              Text('Details',style: TextStyle(color: Color(0xFF1C6494), fontSize:20 ),),
              TextField(
                maxLines: 5,
                onChanged:
                    (value){
                  detail = value;
                },

                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent) ,
                      borderRadius: BorderRadius.all(Radius.circular(10))
                  ),
                  hintText: 'write the details you want to ask for',
                  hintStyle: TextStyle(color: Colors.white),
                  filled: true,
                  fillColor: Color(0xFF2C8CBC),
                ),
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(height: 10),
              Center(
                child: SizedBox(
                  height: 60,
                  width: 190,
                  child: ElevatedButton(
                    child: Text('get pricing'),
                    onPressed: () {
                      sendMail();
                      final snackBar = SnackBar(
                        content: Text('Request sent'),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);


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
    );
  }
}
