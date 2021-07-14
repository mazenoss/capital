import 'package:flutter/material.dart';

class Crane extends StatefulWidget {
  @override
  _CraneState createState() => _CraneState();
}

class _CraneState extends State<Crane> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('order a crane'),
      ),
    );
  }
}
