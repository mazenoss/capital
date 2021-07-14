import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:capital/authentication_wrapper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:capital/fire_store.dart';
import 'package:intl/intl.dart';

class Policies extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return PoliciesState();
  }

}

class PoliciesState extends State<Policies>{
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


  Future<void> _signout() async {
    auth.signOut();
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => AuthenticationWrapper()));
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



  Widget showData(){
    if(policies != null && policies.docs != null){
      return ListView.builder(
        itemCount: policies.docs.length,
        itemBuilder: (BuildContext context, index){
          return Container(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8.0,10,8,5),
              child: Column(
                children: [
                  Card(
                    child: ListTile(
                      title: Text(' ${policies.docs[index].data()['title']}',
                        style: TextStyle(color: Color(0xFF1C6494), fontSize:20,  ),),
                      subtitle: Text('policy number: ${policies.docs[index].data()['pnum']}\n expiry date: ${DateFormat('yyyy/MM/dd').format(policies.docs[index].data()['exp'].toDate())} ',//the DateFormat function is came from intl package to display the date only
                        style: TextStyle(color: Color(0xFF1C6494), fontSize:15,  ),),

                    ),
                  )
                ],
              ),
            ),
          );
        },

      );
    }else if(policies != null && policies.docs.length == 0){
      return Text('there is no available policies for this account',
        style: TextStyle(color: Color(0xFF1C6494), fontSize:20,  ),);
    }else{
      return Text('Loading ... Please wait',
        style: TextStyle(color: Color(0xFF1C6494), fontSize:20,  ),);
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('My Policies List'),
        actions: <Widget>[

          IconButton(
            icon: const Icon(Icons.exit_to_app),
            tooltip: 'Signout',
            onPressed: () {
              _signout();
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
      body: showData(),
    );
  }

}