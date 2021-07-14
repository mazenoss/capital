import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import '../authentication_wrapper.dart';


class Request extends StatefulWidget {
  @override
  _RequestState createState() => _RequestState();
}

class _RequestState extends State<Request> {
  String name;
  String phone;
  String email;
  String note;

  sendMail() async {


    String username = 'mazenoss@gmail.com';
    String password = 'Newm@zen1';

    final smtpServer = gmail(username, password);

    final message = Message()
      ..from = Address(username, name)
      ..recipients.add('mazenoss@gmail.com')
      ..attachments = []
      ..subject = 'Request from ${name} ${DateTime.now()}'
      ..text = 'name: ${name}\nphone: ${phone}\nemail: ${email}\n---------------\n${note}' ;

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
        title: Text('insurance request'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              Text('Name',
                style: TextStyle(color: Color(0xFF1C6494), fontSize:20 ),),
              SizedBox(width: 10),
              TextField(
                onChanged: (value){
                  name = value;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent) ,
                      borderRadius: BorderRadius.all(Radius.circular(10)),

                  ),
                  hintText: 'Enter your name',
                  hintStyle: TextStyle(color: Colors.white),
                  filled: true,
                  fillColor: Color(0xFF2C8CBC),
                ),
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(height: 10),
              Text('Phone',
                style: TextStyle(color: Color(0xFF1C6494), fontSize:20 ),),
              SizedBox(width: 10),
              TextField(
                onChanged: (value){
                  phone = value;
                },
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent) ,
                    borderRadius: BorderRadius.all(Radius.circular(10)),

                  ),
                  hintText: 'Enter your phone number',
                  hintStyle: TextStyle(color: Colors.white),
                  filled: true,
                  fillColor: Color(0xFF2C8CBC),
                ),
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(height: 10),
              Text('Email',
                style: TextStyle(color: Color(0xFF1C6494), fontSize:20 ),),
              SizedBox(width: 10),
              TextField(
                onChanged: (value){
                  email = value;
                },
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent) ,
                    borderRadius: BorderRadius.all(Radius.circular(10)),

                  ),
                  hintText: 'Enter your Email address',
                  hintStyle: TextStyle(color: Colors.white),
                  filled: true,
                  fillColor: Color(0xFF2C8CBC),
                ),
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(height: 10),
              Text('Details',style: TextStyle(color: Color(0xFF1C6494), fontSize:20 ),),
              TextField(
                maxLines: 5,
                onChanged:
                    (value){
                  note = value;
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
              SizedBox(height: 25),
              Center(
                child: SizedBox(
                  height: 60,
                  width: 190,
                  child: ElevatedButton(
                    child: Text('Request'),
                    onPressed: () async {
                          sendMail();
                          final snackBar = SnackBar(
                            content: Text('Request sent'),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);

                          Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AuthenticationWrapper(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(

                        primary: Color(0xFF2C8CBC),
                        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
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
