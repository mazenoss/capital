import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:capital/fire_store.dart';
import 'package:image_picker/image_picker.dart';




class Accident extends StatefulWidget {


  @override
  _AccidentState createState() => _AccidentState();

}

class _AccidentState extends State<Accident> {

  File _image;
  String _imagePath;
  Future getImage() async {
    final image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = image;
    });
  }


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


 

   getLocation() async{

    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

      setState(() {
        location = '${position.latitude},${position.longitude}';
      });

  }

var location = '';
   String note = '';

  sendMail() async {


    String username = 'mazenoss@gmail.com';
    String password = 'Newm@zen1';

    final smtpServer = gmail(username, password);

    final message = Message()
      ..from = Address(username, '${name.docs[0].data()['name']}')
      ..recipients.add('mazenoss@gmail.com')
      ..attachments = [
        FileAttachment(File(''))
      ]
      ..subject = 'urgent ${DateTime.now()}'
      ..text = 'https://www.google.com/maps?q=${location.toString()}\n $note\n${name.docs[0].data()['name']}\n${name.docs[0].data()['phone']}' ;

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
        title: Text('report an accident'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                  'If you have an accident now, just press the button and the phone will send your location and your data to us and we will call you',
                  style: TextStyle(color: Color(0xFF1C6494), fontSize:20,  ),
                textAlign: TextAlign.center,

              ),
              SizedBox(height: 15,),
              Container(
                height:  150,
                child: TextField(
                  maxLines: 5,
                  onChanged: (value){
                    note = value;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent) ,
                        borderRadius: BorderRadius.all(Radius.circular(10))
                    ),
                    hintText: 'you can send an optional note here',
                    hintStyle: TextStyle(color: Colors.white),
                    filled: true,
                    fillColor: Color(0xFF2C8CBC),
                  ),
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(height: 25,),
             // Center(child:_image == null ? Text('') : Image.file(_image),),
              Center(
                child: SizedBox(
                  height: 60,
                  width: 190,
                  child: ElevatedButton(
                    child: Text('get help'),
                    onPressed: () {
                     getLocation().then((location) => sendMail());
                     final snackBar = SnackBar(
                       content: Text('Report sent'),
                      );
                     ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    },
                    style: ElevatedButton.styleFrom(
                        primary: Color(0xFFBF0641),
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
