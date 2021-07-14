import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:capital/authentication_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:capital/authentication_wrapper.dart';
import 'package:capital/fire_store.dart';
import 'package:capital/screens/pricing.dart';
import 'package:capital/screens/policies.dart';

class Home extends StatefulWidget {


  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

   String uid = FirebaseAuth.instance.currentUser.uid.toString();
   Crud crud = new Crud();
   QuerySnapshot policies;
   User user;
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
     crud.getData().then((data){
       setState(() {
         policies = data;
       });
     });

   }
   Widget available(){
     if(policies != null && policies.docs.length == 0 ){
       return Column(
         children: [
           Padding(
             padding: const EdgeInsets.all(8.0),
             child: Text('there is no available policies, press the button to send your request',
               style: TextStyle(color: Color(0xFF1C6494), fontSize:20,  ),
               textAlign: TextAlign.center,),
           ),
           SizedBox(height: 20,),
           ElevatedButton(
             child: Text('press to ask'),
             onPressed: () {

               Navigator.push(
                 context,
                 MaterialPageRoute(
                   builder: (context) => Pricing(),
                 ),
               );
             },
             style: ElevatedButton.styleFrom(
                 primary: Color(0xFF2C8CBC),
                 padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                 textStyle: TextStyle(
                     fontSize: 20,
                     fontWeight: FontWeight.bold)),
           ),
                    ],
       );
     }else if(policies != null && policies.docs != null){
       return ElevatedButton(
         child: Text('show your policies'),
         onPressed: () {

           Navigator.push(
             context,
             MaterialPageRoute(
               builder: (context) => Policies(),
             ),
           );
         },
         style: ElevatedButton.styleFrom(
             primary: Color(0xFF2C8CBC),
             padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
             textStyle: TextStyle(
                 fontSize: 20,
                 fontWeight: FontWeight.bold)),
       );
     }else { return Text('please wait...',
       style: TextStyle(color: Color(0xFF1C6494), fontSize:20,  ),
       textAlign: TextAlign.center,);}
   }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home screen'),
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            tooltip: 'Signout',
            onPressed: () {
              context.read<AuthenticationService>().signOut();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AuthenticationWrapper(),
                ),
              );
                   },
          ),
        ],
      ),
      body:
      StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Users').where('uid', isEqualTo: uid ).snapshots(),
        builder: (context, snapshots){
          if(!snapshots.hasData) return Text('No Data');
          return Center(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Welcome\n${snapshots.data.docs[0]['name']}',
                    style: TextStyle(color: Color(0xFF1C6494), fontSize:40,  ),
                    textAlign: TextAlign.center,),
                  SizedBox(height: 20,),
                  available()
               ],
              ),
            ),
          );
        },
      ),
  );
  }
}