import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';




  Future <void> userSetup(String name, String phone, String email,) async {
    CollectionReference users = FirebaseFirestore.instance.collection('Users');
    FirebaseAuth auth = FirebaseAuth.instance;
    String uid = auth.currentUser.uid.toString();
    users.add({
      'name': name,
      'phone': phone,
      'email': email,
      'uid': uid,
    });
    return;
  }

  Future <void> pricingFireStore(String name, String phone, String email,
      String car, String year) async {
    CollectionReference pricing = FirebaseFirestore.instance.collection(
        'pricing');
    pricing.add({
      'name': name,
      'phone': phone,
      'email': email,
      'car': car,
      'year': year,
    });
    return;
  }

  Future  requestFireStore(String name, String phone,
      String email) async {
    CollectionReference request = FirebaseFirestore.instance.collection(
        'request');
    request.add({
      'name': name,
      'phone': phone,
      'email': email,
    });
    return;
  }
class Crud {
  getData() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    String uid = auth.currentUser.uid.toString();
    return await FirebaseFirestore.instance.collection('policies').where('uid', isEqualTo: uid ).get();
  }

  getName() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    String uid = auth.currentUser.uid.toString();
    return await FirebaseFirestore.instance.collection('Users').where('uid', isEqualTo: uid ).get();

  }
}

